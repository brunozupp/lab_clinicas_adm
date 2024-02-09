import 'package:flutter/material.dart';
import 'package:lab_clinicas_adm/src/pages/checkin/widgets/checkin_image_dialog.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

class CheckinImageLink extends StatelessWidget {

  final String label;
  final String image;

  const CheckinImageLink({
    super.key,
    required this.label,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showImageDialog(context),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: LabClinicasTheme.blueColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  void showImageDialog(BuildContext context) {
    showDialog(context: context, builder: (context) {
      return CheckinImageDialog(context: context, pathImage: image);
    });
  }
}
