import 'package:asyncstate/asyncstate.dart';
import 'package:lab_clinicas_adm/src/services/login/i_user_login_service.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

class LoginController with MessageStateMixin {
  final IUserLoginService _userLoginService;

  LoginController({
    required IUserLoginService userLoginService,
  }) : _userLoginService = userLoginService;

  final _obscurePassword = signal(true);
  bool get obscurePassword => _obscurePassword();

  final _logged = signal(false);
  bool get logged => _logged();

  void togglePassword() => _obscurePassword.value = !_obscurePassword.value;

  Future<void> login(String email, String password) async {
    final loginResult =
        await _userLoginService.execute(email, password).asyncLoader();

    switch (loginResult) {
      case Left(value: ServiceException(:final message)):
        showError(message);
      case Right(value: _):
        _logged.value = true;
    }
  }
}
