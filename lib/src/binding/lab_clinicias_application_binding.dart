import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_adm/src/core/env.dart';
import 'package:lab_clinicas_adm/src/repositories/attendant_desk_assignment/attendant_desk_assignment_repository.dart';
import 'package:lab_clinicas_adm/src/repositories/attendant_desk_assignment/i_attendant_desk_assignment_repository.dart';
import 'package:lab_clinicas_adm/src/repositories/panel/i_panel_repository.dart';
import 'package:lab_clinicas_adm/src/repositories/panel/panel_repository.dart';
import 'package:lab_clinicas_adm/src/repositories/patient_information_form/i_patient_information_form_repository.dart';
import 'package:lab_clinicas_adm/src/repositories/patient_information_form/patient_information_form_repository.dart';
import 'package:lab_clinicas_adm/src/services/call_next_patient/call_next_patient_service.dart';
import 'package:lab_clinicas_adm/src/services/call_next_patient/i_call_next_patient_service.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

class LabCliniciasApplicationBinding extends ApplicationBindings {
  
  @override
  List<Bind<Object>> bindings() => [
    Bind.lazySingleton<RestClient>((i) => RestClient(Env.backendBaseUrl)),
    Bind.lazySingleton<IPatientInformationFormRepository>((i) => PatientInformationFormRepository(
      restClient: i(),
    )),
    Bind.lazySingleton<IAttendantDeskAssignmentRepository>((i) => AttendantDeskAssignmentRepository(
      restClient: i(),
    )),
    Bind.lazySingleton<IPanelRepository>((i) => PanelRepository(
      restClient: i(),
    )),
    Bind.lazySingleton<ICallNextPatientService>((i) => CallNextPatientService(
      patientInformationFormRepository: i(), 
      attendantDeskAssignmentRepository: i(), 
      panelRepository: i(),
    )),
  ];
  
}