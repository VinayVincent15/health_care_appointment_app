import 'package:flutter/material.dart';

import 'constrants.dart';
class TextFieldWidget extends StatefulWidget {
  final int maxLines;
  final String label;
  final String text;
  final bool enabled;
  final ValueChanged<String> onChanged;

  const TextFieldWidget({
    Key? key,
    this.maxLines = 1,
    required this.label,
    required this.text,
    required this.onChanged, required this.enabled,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        widget.label,
        style:textCyanheading,
      ),
      const SizedBox(height: 8),
      TextField(
        onChanged: widget.onChanged,
        enabled: widget.enabled,
        controller: controller,
        decoration: InputDecoration(
          hintStyle:const TextStyle(color: Colors.green),
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30)
          ),
          fillColor:  const Color(0xFFFFE9EF),
          filled: true,
        ),
        style: const TextStyle(
          color: Colors.green,
        ),
        maxLines: widget.maxLines,
      ),
    ],
  );
}