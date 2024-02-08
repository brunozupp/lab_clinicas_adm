import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lab_clinicas_adm/src/models/patient_information_form_model.dart';
import 'package:lab_clinicas_adm/src/repositories/attendant_desk_assignment/i_attendant_desk_assignment_repository.dart';
import 'package:lab_clinicas_adm/src/repositories/panel/i_panel_repository.dart';
import 'package:lab_clinicas_adm/src/repositories/patient_information_form/i_patient_information_form_repository.dart';
import 'package:lab_clinicas_adm/src/services/call_next_patient/i_call_next_patient_service.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

class CallNextPatientService implements ICallNextPatientService {

  final IPatientInformationFormRepository _patientInformationFormRepository;
  final IAttendantDeskAssignmentRepository _attendantDeskAssignmentRepository;
  final IPanelRepository _panelRepository;

  CallNextPatientService({
    required IPatientInformationFormRepository patientInformationFormRepository,
    required IAttendantDeskAssignmentRepository attendantDeskAssignmentRepository,
    required IPanelRepository panelRepository,
  })  : _patientInformationFormRepository = patientInformationFormRepository,
        _attendantDeskAssignmentRepository = attendantDeskAssignmentRepository,
        _panelRepository = panelRepository;


  @override
  Future<Either<RepositoryException, PatientInformationFormModel?>> execute() async {
    
    try {

      final result = await _patientInformationFormRepository.callNextCheckIn();

      switch(result) {
        case Left(value: final exception):
          return Left(exception);
        case Right(value: final form?):
          return updatePanel(form);
        case Right():
          return Right(null);
      }

    } on DioException catch(e, s) {

      log("message", error: e, stackTrace: s);

      return Left(RepositoryException());
    }
  }
  
  Future<Either<RepositoryException, PatientInformationFormModel?>> updatePanel(PatientInformationFormModel form) async {

    final resultDesk = await _attendantDeskAssignmentRepository.getDeskAssignmento();

    switch(resultDesk) {
      case Left(value: final exception):
        return Left(exception);
      case Right(value: final deskNumber):
        final panelResult = await _panelRepository.callOnPanel(form.password, deskNumber);

          switch(panelResult) {
            case Left(value: final exception):
              log(
                "ATENÇÃO!!! Não foi possível chamar o paciente no painel", 
                error: exception, 
                stackTrace: StackTrace.fromString("ATENÇÃO!!! Não foi possível chamar o paciente no painel"),
              );
              return Right(form);
            case Right():
              return Right(form);
          }
    }
  }
  
}