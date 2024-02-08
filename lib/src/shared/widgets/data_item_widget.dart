import 'package:flutter/material.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

class DataItemWidget extends StatelessWidget {

  final String label;
  final String value;
  final EdgeInsetsGeometry? padding;

  const DataItemWidget({
    super.key,
    required this.label,
    required this.value,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              color: LabClinicasTheme.blueColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: LabClinicasTheme.orangeColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}