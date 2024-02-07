import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_adm/src/binding/lab_clinicias_application_binding.dart';
import 'package:lab_clinicas_adm/src/pages/login/login_router.dart';
import 'package:lab_clinicas_adm/src/pages/splash/splash_page.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

void main() {
  runZonedGuarded(() async {

    WidgetsFlutterBinding.ensureInitialized();

    runApp(const LabClinicasAdmApp());
  }, (error, stack) { 
    log("Erro não tratado", error: error, stackTrace: stack);
    throw error;
  });
}

class LabClinicasAdmApp extends StatelessWidget {
  const LabClinicasAdmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LabClinicasCoreConfig(
      title: "Lab Clinicas Adm",
      binding: LabCliniciasApplicationBinding(),
      pagesBuilders: [
        FlutterGetItPageBuilder(
          page: (_) => const SplashPage(), 
          path: "/",
        ),
      ],
      pages: const [
        LoginRouter(),
      ],
      // modules: [
      //   AuthModule(),
      //   HomeModule(),
      //   SelfServiceModule()
      // ],
    );
  }
}