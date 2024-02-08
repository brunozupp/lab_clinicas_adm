import 'package:asyncstate/asyncstate.dart' as asyncstate;
import 'package:lab_clinicas_adm/src/repositories/attendant_desk_assignment/i_attendant_desk_assignment_repository.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

class HomeController with MessageStateMixin {
  
  final IAttendantDeskAssignmentRepository _attendantDeskAssignmentRepository;

  HomeController({
    required IAttendantDeskAssignmentRepository
        attendantDeskAssignmentRepository,
  }) : _attendantDeskAssignmentRepository = attendantDeskAssignmentRepository;

  Future<void> startService(int deskNumber) async {

    asyncstate.AsyncState.show();

    final result = await _attendantDeskAssignmentRepository.startService(deskNumber);

    switch(result) {
      case Left():
        asyncstate.AsyncState.hide();
        showError("Erro ao iniciar o Guichê");
      case Right():
        asyncstate.AsyncState.hide();
        
    }
  }
}