import '../utils/exported_file.dart';

class RepoStateController<T> extends StateNotifier<AsyncValue<T>> {
  RepoStateController() : super(const AsyncLoading());
  void setLoading() => state = const AsyncLoading();
  void setData(T value) => state = AsyncData(value);
  void setError(Object e, StackTrace st) => state = AsyncError(e, st);
}
