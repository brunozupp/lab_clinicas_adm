import 'package:flutter/material.dart';
import 'package:lab_clinicas_adm/src/shared/widgets/data_item_widget.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

class PreCheckinPage extends StatelessWidget {
  const PreCheckinPage({super.key});

  @override
  Widget build(BuildContext context) {

    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: LabClinicasAppBar(),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: sizeOf.width * 0.5,
            margin: const EdgeInsets.only(top: 56),
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: LabClinicasTheme.orangeColor,
              ),
            ),
            child: Column(
              children: [
                Image.asset("assets/images/patient_avatar.png"),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "A senha chamada foi",
                  style: LabClinicasTheme.titleSmallStyle,
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 218,
                    minHeight: 48,
                  ),
                  decoration: BoxDecoration(
                    color: LabClinicasTheme.orangeColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    "selfServiceController.password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
                const DataItemWidget(
                  label: "Nome do paciente", 
                  value: "value",
                  padding: EdgeInsets.only(bottom: 24),
                ),
                const DataItemWidget(
                  label: "Email", 
                  value: "value",
                  padding: EdgeInsets.only(bottom: 24),
                ),
                const DataItemWidget(
                  label: "Telefone de contato", 
                  value: "value",
                  padding: EdgeInsets.only(bottom: 24),
                ),
                const DataItemWidget(
                  label: "CPF", 
                  value: "value",
                  padding: EdgeInsets.only(bottom: 24),
                ),
                const DataItemWidget(
                  label: "CEP", 
                  value: "value",
                  padding: EdgeInsets.only(bottom: 24),
                ),
                const DataItemWidget(
                  label: "Endereço", 
                  value: "value",
                  padding: EdgeInsets.only(bottom: 24),
                ),
                const DataItemWidget(
                  label: "Responsável", 
                  value: "value",
                  padding: EdgeInsets.only(bottom: 24),
                ),
                const DataItemWidget(
                  label: "Documento de identidade", 
                  value: "value",
                  padding: EdgeInsets.only(bottom: 24),
                ),
                const SizedBox(
                  height: 48,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text("CHAMAR OUTRA SENHA"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text("ATENDER"),
                        ),
                      ),
                    ),
                  
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}