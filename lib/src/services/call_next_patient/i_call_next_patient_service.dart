import 'package:lab_clinicas_adm/src/models/patient_information_form_model.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

abstract interface class ICallNextPatientService {

  Future<Either<RepositoryException, PatientInformationFormModel?>> execute();
}