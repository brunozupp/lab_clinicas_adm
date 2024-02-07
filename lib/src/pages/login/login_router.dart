import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_adm/src/pages/login/login_controller.dart';
import 'package:lab_clinicas_adm/src/pages/login/login_page.dart';
import 'package:lab_clinicas_adm/src/repositories/user/i_user_repository.dart';
import 'package:lab_clinicas_adm/src/repositories/user/user_repository.dart';
import 'package:lab_clinicas_adm/src/services/login/i_user_login_service.dart';
import 'package:lab_clinicas_adm/src/services/login/user_login_service.dart';

class LoginRouter extends FlutterGetItPageRouter {
  
  const LoginRouter({super.key});

  @override
  String get routeName => "/login";

  @override
  List<Bind<Object>> get bindings => [
    Bind.lazySingleton<IUserRepository>((i) => UserRepository(
      restClient: i(),
    )),
    Bind.lazySingleton<IUserLoginService>((i) => UserLoginService(
      userRepository: i(),
    )),
    Bind.lazySingleton<LoginController>((i) => LoginController(
      userLoginService: i(),
    )),
    
  ];

  @override
  WidgetBuilder get view => (_) => const LoginPage();
}