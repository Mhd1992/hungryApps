import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.isPassword,
    required this.controller,
  });
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.isPassword;
    super.initState();
  }

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        fillColor: Colors.white,
        filled: true,
        hint: Text(widget.hintText),
        suffixIcon: (widget.isPassword)
            ? GestureDetector(
                onTap: _togglePassword,
                child: _obscureText
                    ? Icon(CupertinoIcons.eye)
                    : Icon(CupertinoIcons.eye_slash),
              )
            : null,
      ),
      obscureText: _obscureText,
      validator: (val) {
        if (val == null || val.isEmpty) {
          print('am in null block validators');

          return 'Please Enter ${widget.hintText}';
        }
        return null;
      },
    );
  }
}
