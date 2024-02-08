import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_adm/src/pages/home/home_controller.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:validatorless/validatorless.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with MessageViewMixin {

  final _formKey = GlobalKey<FormState>();
  final _deskNumberEC = TextEditingController();

  final _controller = Injector.get<HomeController>();

  @override
  void initState() {
    messageListener(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _deskNumberEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: LabClinicasAppBar(),
      body: Center(
        child: Container(
          width: sizeOf.width * 0.4,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: LabClinicasTheme.orangeColor,
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Bem-vindo",
                  style: LabClinicasTheme.titleStyle,
                ),
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  "Preencha o número do guichê que você está atendendo",
                  style: LabClinicasTheme.subTitleSmallStyle,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: _deskNumberEC,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: Validatorless.multiple([
                    Validatorless.required("Guichê obrigatório"),
                    Validatorless.number("Guichê deve ser um número"),
                  ]),
                  decoration: const InputDecoration(
                    label: Text("Número do guichê"),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      
                      final valid = _formKey.currentState?.validate() ?? false;

                      if(valid) {

                        _controller.startService(int.parse(_deskNumberEC.text));
                      }
                    }, 
                    child: const Text("CHAMAR PRÓXIMO PACIENTE"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}