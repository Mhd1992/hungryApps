import 'package:hungry/core/utils/exported_file.dart';

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
        hint: CustomText(text: widget.hintText, color: Colors.black),
        suffixIcon: (widget.isPassword)
            ? GestureDetector(
                onTap: _togglePassword,
                child: _obscureText
                    ? Icon(CupertinoIcons.eye, color: AppColors.primaryColor)
                    : Icon(
                        CupertinoIcons.eye_slash,
                        color: AppColors.primaryColor,
                      ),
              )
            : null,
      ),
      obscureText: _obscureText,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Please Enter ${widget.hintText}';
        }
        return null;
      },
    );
  }
}
