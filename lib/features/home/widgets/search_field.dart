import 'package:hungry/core/utils/exported_file.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      shadowColor: Colors.grey.shade700,
      borderRadius: BorderRadius.circular(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.white),
          ),
          prefixIcon: Icon(CupertinoIcons.search),
        ),
      ),
    );
  }
}
