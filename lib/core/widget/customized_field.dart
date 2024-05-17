import 'package:flutter/material.dart';

class CustomizedField extends StatefulWidget {
  final String? hintText;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  bool obscureText;
  final bool isPassword;
  final Color color;
  final String? labelText;
  final Color colorText;
  final int? maxLength;

  CustomizedField({super.key, this.hintText, required this.controller, required this.validator, this.keyboardType, this.obscureText = false, this.isPassword = false, required this.color, this.labelText, required this.colorText, this.maxLength,});

  @override
  State<CustomizedField> createState() => _CustomizedFieldState();
}

class _CustomizedFieldState extends State<CustomizedField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, ),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: const BorderRadius.all(Radius.circular(25)),
          ),
          child: TextFormField(
            maxLength: widget.maxLength,
            controller: widget.controller,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            style: TextStyle(color: widget.colorText, fontSize: 18),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              suffixIcon: widget.isPassword ? IconButton(
                icon: Icon(
                  widget.obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.yellow,
                ),
                onPressed: () {
                  setState(() {
                    widget.obscureText = !widget.obscureText;
                  });
                },
              ) : null,
              labelText: widget.labelText,
              labelStyle:const TextStyle(
                color:  Color(0xFF988F8C),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              hintText: widget.hintText,
              errorStyle: const TextStyle(fontSize: 10),
              border: InputBorder.none,
              hintStyle: const TextStyle(
                color:  Color(0xFF988F8C),
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
