import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'package:lab_clinicas_adm/src/models/patient_information_form_model.dart';
import 'package:lab_clinicas_adm/src/repositories/patient_information_form/i_patient_information_form_repository.dart';

class CheckinController with MessageStateMixin {
  
  final IPatientInformationFormRepository _patientInformationFormRepository;

  CheckinController({
    required IPatientInformationFormRepository patientInformationFormRepository,
  }) : _patientInformationFormRepository = patientInformationFormRepository;

  final informationForm = signal<PatientInformationFormModel?>(null);

  final endProcess = signal<bool>(false);

  Future<void> endCheckin() async {

    if(informationForm() != null) {
      final result = await _patientInformationFormRepository.updateStatus(informationForm.value!.id, PatientInformationFormStatus.beingAttended);
    
      switch(result) {
        case Left():
          showError("Erro ao atualizar o status do formulário");
        case Right():
          endProcess.value = true;
      }

    } else {
      showInfo("Formulário não pode ser nulo");
    }
  }
}
