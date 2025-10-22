import 'package:hungry/core/utils/exported_file.dart';

class CustomUserTextField extends StatelessWidget {
  const CustomUserTextField({
    super.key,
    required this.controller,
    required this.filed,
  });
  final TextEditingController controller;
  final String filed;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorHeight: 20,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white), //to make writing color white
      decoration: InputDecoration(
        label: Text(filed),
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
