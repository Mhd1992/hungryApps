import 'package:hungry/shared/server_failure_logo.dart';

import '../utils/exported_file.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({super.key, required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    if (error is ApiError) {
      final apiError = error as ApiError;
      if (apiError.statusCode == 500) {
        //return Center(child: Icon(Icons.error, size: 20));
        return Center(
          child: ServerFailureLogo(
            color: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
            height: 200,
          ),
        );
      }
      if (apiError.statusCode == 401) {
        return Center(child: Text('unAuthorized'));
      }
      if (apiError.statusCode == 401) {
        return Center(child: Text('notFoundContent'));
      }
    }
    return Center(child: Text('something went error'));
  }
}
