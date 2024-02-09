
import 'package:flutter/material.dart';
import 'package:lab_clinicas_adm/src/core/env.dart';

class CheckinImageDialog extends AlertDialog {
  
  CheckinImageDialog({super.key, required BuildContext context, required String pathImage}) : super(
    content: Image.network(
      "${Env.backendBaseUrl}/$pathImage",
      fit: BoxFit.cover,
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text("Fechar"),
      ),
    ]
  );
  
}