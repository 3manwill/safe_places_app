import 'package:flutter/material.dart';

class PlaceField extends StatelessWidget {
  final String title;
  final String value;

  const PlaceField({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$title:', style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 5),
        Text(value)
      ],
    );
  }
}
