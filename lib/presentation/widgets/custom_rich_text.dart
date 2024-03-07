import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({super.key, required this.label, this.text = "Unknown"});

  final String label;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:2),
      child: RichText(
        text: TextSpan(
            text: "$label : ".toUpperCase(),
            style: const TextStyle(color: Colors.grey),
            children: [
              TextSpan(text: text, style: Theme.of(context).textTheme.bodyLarge)
            ]),
      ),
    );
  }
}
