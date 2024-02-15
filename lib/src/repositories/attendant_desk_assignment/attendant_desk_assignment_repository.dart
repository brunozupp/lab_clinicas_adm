import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lab_clinicas_adm/src/repositories/attendant_desk_assignment/i_attendant_desk_assignment_repository.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

class AttendantDeskAssignmentRepository implements IAttendantDeskAssignmentRepository {
  
  final RestClient _restClient;

  AttendantDeskAssignmentRepository({
    required RestClient restClient,
  }) : _restClient = restClient;
  
  @override
  Future<Either<RepositoryException, Unit>> startService(int deskNumber) async {
    
    try {

      final result = await _clearDeskByUser();

      switch(result) {
        case Left(value: final excepiton):
          return Left(excepiton);
        case Right():
          await _restClient.auth.post("/attendantDeskAssignment", data: {
            "user_id": "#userAuthRef",
            "desk_number": deskNumber,
            "date_created": DateTime.now().toIso8601String(),
            "status": "Available",
          });

          return Right(unit);
      }

    } on DioException catch(e, s) {
      log("message", error: e, stackTrace: s);

      return Left(RepositoryException());
    }
  }

  Future<({String id, int deskNumber})?> _getDeskByUser() async {

    final Response(:List data) = await _restClient.auth.get(
      "/attendantDeskAssignment", 
        queryParameters: {
        "user_id": "#userAuthRef", // Um coringa esse # -> quando o json_rest_server intercepta esse cara, ele substitui esse cara pelo valor dentro do token
      },
    );

    if(data.isNotEmpty case List(isNotEmpty:true, first: {"id": String id, "desk_number": int deskNumber})) {
      return (
        id: id,
        deskNumber: deskNumber,
      );
    }

    return null;
  }

  Future<Either<RepositoryException, Unit>> _clearDeskByUser() async {

    try {
      final desk = await _getDeskByUser();

      if(desk != null) {
        await _restClient.auth.delete("/attendantDeskAssignment/${desk.id}");
      }

      return Right(Unit());

    } on DioException catch(e,s) {
      log("Erro ao deletar número do guichê", error: e, stackTrace: s);

      return Left(RepositoryException());
    }
  }
  
  @override
  Future<Either<RepositoryException, int>> getDeskAssignmento() async {
    
    try {
      final Response(data: List(first: data)) = await _restClient.auth.get("/attendantDeskAssignment", queryParameters: {
        "user_id": "#userAuthRef",
      });
      
      return Right(data["desk_number"]);
    } on DioException catch (e,s) {
      
      log("Erro ao buscar número do guichê", error: e, stackTrace: s);

      return Left(RepositoryException());
    }
  }
}