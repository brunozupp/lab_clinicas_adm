import 'package:asyncstate/asyncstate.dart' as asyncstate;
import 'package:lab_clinicas_adm/src/models/patient_information_form_model.dart';
import 'package:lab_clinicas_adm/src/repositories/attendant_desk_assignment/i_attendant_desk_assignment_repository.dart';
import 'package:lab_clinicas_adm/src/services/call_next_patient/i_call_next_patient_service.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

class HomeController with MessageStateMixin {
  final IAttendantDeskAssignmentRepository _attendantDeskAssignmentRepository;
  final ICallNextPatientService _callNextPatientService;

  HomeController({
    required IAttendantDeskAssignmentRepository
        attendantDeskAssignmentRepository,
    required ICallNextPatientService callNextPatientService,
  })  : _attendantDeskAssignmentRepository = attendantDeskAssignmentRepository,
        _callNextPatientService = callNextPatientService;

  final _informationForm = signal<PatientInformationFormModel?>(null);
  PatientInformationFormModel? get informationForm => _informationForm();

  Future<void> startService(int deskNumber) async {
    asyncstate.AsyncState.show();

    final result =
        await _attendantDeskAssignmentRepository.startService(deskNumber);

    switch (result) {
      case Left():
        asyncstate.AsyncState.hide();
        showError("Erro ao iniciar o Guichê");
      case Right():
        final resultNextPatient = await _callNextPatientService.execute();

        switch (resultNextPatient) {
          case Left():
            showError("Erro ao chamar o próximo paceiente");
          case Right(value: final form?):
            asyncstate.AsyncState.hide();
            _informationForm.value = form;
          case Right(value: _):
            asyncstate.AsyncState.hide();
            showInfo("Nenhum paciente aguardando");
        }
    }
  }
}
