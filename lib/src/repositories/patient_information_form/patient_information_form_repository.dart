import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lab_clinicas_adm/src/models/patient_information_form_model.dart';
import 'package:lab_clinicas_adm/src/repositories/patient_information_form/i_patient_information_form_repository.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

class PatientInformationFormRepository implements IPatientInformationFormRepository {
  
  final RestClient _restClient;

  PatientInformationFormRepository({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<Either<RepositoryException, PatientInformationFormModel?>> callNextCheckIn() async {
    
    try {

      final Response(:List data) = await _restClient.auth.get("/patientInformationForm", queryParameters: {
        "status": PatientInformationFormStatus.waiting.id,
        "page": 1,
        "limit": 1,
      });

      if(data.isEmpty) {
        return Right(null);
      }

      final formData = data.first;

      final updateStatusResult = await updateStatus(formData["id"], PatientInformationFormStatus.checkIn);

      switch(updateStatusResult) {
        case Left(value: final exception):
          return Left(exception);
        case Right():
          formData["status"] = PatientInformationFormStatus.checkIn.id;

          formData["patient"] = await _getPatient(formData["patient_id"]);

          return Right(PatientInformationFormModel.fromJson(formData));
      }

    } on DioException catch(e,s) {

      log("Erro ao chamar o próximo paciente", error: e, stackTrace: s);

      return Left(RepositoryException());
    }
  }

  @override
  Future<Either<RepositoryException, Unit>> updateStatus(String id, PatientInformationFormStatus status) async {
    
    try {

      await _restClient.auth.put("/patientInformationForm/$id", data: {
        "status": status.id,
      });

      return Right(unit);

    } on DioException catch(e,s) {

      log("Erro ao atualizar status", error: e, stackTrace: s);

      return Left(RepositoryException());
    }
  }

  Future<Map<String, dynamic>> _getPatient(String id) async {
    final Response(:data) = await _restClient.auth.get("/patients/$id");
    return data;
  }
}