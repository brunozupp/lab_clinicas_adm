import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_adm/src/pages/checkin/checkin_controller.dart';
import 'package:lab_clinicas_adm/src/pages/checkin/widgets/checkin_image_link.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../models/patient_information_form_model.dart';
import '../../shared/widgets/data_item_widget.dart';

class CheckinPage extends StatefulWidget {
  const CheckinPage({super.key});

  @override
  State<CheckinPage> createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> with MessageViewMixin {

  final _controller = Injector.get<CheckinController>();

  @override
  void initState() {
    messageListener(_controller);

    effect(() {

      if(_controller.endProcess.value) {
        Navigator.of(context).pushReplacementNamed("/end-checkin");
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PatientInformationFormModel(:password, :patient, :medicalOrders, :healthInsuranceCard) = _controller.informationForm.watch(context)!;

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
                  child: Text(
                    password,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: LabClinicasTheme.lightOrangeColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    "Cadastro",
                    style: LabClinicasTheme.subTitleSmallStyle.copyWith(
                      color: LabClinicasTheme.orangeColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                DataItemWidget(
                  label: "Nome do paciente", 
                  value: patient.name,
                  padding: const EdgeInsets.only(bottom: 24),
                ),
                DataItemWidget(
                  label: "Email", 
                  value: patient.email,
                  padding: const EdgeInsets.only(bottom: 24),
                ),
                DataItemWidget(
                  label: "Telefone de contato", 
                  value: patient.phoneNumber,
                  padding: const EdgeInsets.only(bottom: 24),
                ),
                DataItemWidget(
                  label: "CPF", 
                  value: patient.document,
                  padding: const EdgeInsets.only(bottom: 24),
                ),
                DataItemWidget(
                  label: "CEP", 
                  value: patient.address.cep,
                  padding: const EdgeInsets.only(bottom: 24),
                ),
                DataItemWidget(
                  label: "Endereço", 
                  value: "${patient.address.streetAddress}, ${patient.address.number} ${patient.address.addressComplement}, ${patient.address.district}, ${patient.address.city} - ${patient.address.state}",
                  padding: const EdgeInsets.only(bottom: 24),
                ),
                DataItemWidget(
                  label: "Responsável", 
                  value: patient.guardian,
                  padding: const EdgeInsets.only(bottom: 24),
                ),
                DataItemWidget(
                  label: "Documento de identidade", 
                  value: patient.guardianIdentificationNumber,
                  padding: const EdgeInsets.only(bottom: 24),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: LabClinicasTheme.lightOrangeColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    "Validar Exames",
                    style: LabClinicasTheme.subTitleSmallStyle.copyWith(
                      color: LabClinicasTheme.orangeColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CheckinImageLink(
                      label: "Carteirinha",
                      image: healthInsuranceCard,
                    ),
                    Column(
                      children: [
                        for(final (index, medicalOrder) in medicalOrders.indexed)
                          CheckinImageLink(
                            label: "Pedido médico ${index + 1}",
                            image: medicalOrder,
                          ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _controller.endCheckin();
                    },
                    child: const Text("FINALIZAR ATENDIMENTO"),
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
