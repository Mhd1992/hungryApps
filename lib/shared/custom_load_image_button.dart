import 'package:hungry/core/utils/exported_file.dart';

class CustomLoadImageButton extends StatelessWidget {
  const CustomLoadImageButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.width,
    this.color,
  });
  final String buttonText;
  final VoidCallback onPressed;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(Icons.camera_alt_outlined, color: Colors.white, size: 32),
    );
  }
}
