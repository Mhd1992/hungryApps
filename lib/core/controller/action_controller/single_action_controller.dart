part of 'action_controllers.dart';

class SingleCommand<DataT> extends StateNotifier<AsyncState<DataT>> {
  SingleCommand(
    FutureRepoResult<DataT> repo, {
    required ActionStrategy strategy,
  }) : _controller = ConcurrentController<DataT, Null>(
         repo: (_) => repo(), // the arg is always null
         strategy: strategy,
       ),
       super(Init<DataT>()) {
    final stream = _controller.stream;
    _subscription = stream.listen((event) {
      state = event.data;
    });
  }

  final ConcurrentController<DataT, Null> _controller;
  StreamSubscription? _subscription;

  void add() {
    _controller.fire(null);
  }

  @override
  void dispose() async {
    await _controller.close();
    await _subscription?.cancel();
    super.dispose();
  }
}
