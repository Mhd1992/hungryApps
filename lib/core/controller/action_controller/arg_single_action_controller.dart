part of 'action_controllers.dart';

class SingleActionArgControllerState<DataT, Arg extends Record> {
  const SingleActionArgControllerState({required this.state, required Arg? key})
    : _arg = key;
  factory SingleActionArgControllerState.init() {
    return SingleActionArgControllerState(state: Init<DataT>(), key: null);
  }
  final AsyncState<DataT> state;
  final Arg? _arg;

  // TODO: this for arg commands only
  Arg get arg => _arg!;

  AsyncState<DataT> stateFor(bool Function(Arg key) match) {
    if (_arg == null) return Init<DataT>();
    return match(_arg) ? state : Init<DataT>();
  }
}

class SingleActionArgController<DataT, Arg extends Record>
    extends StateNotifier<SingleActionArgControllerState<DataT, Arg>> {
  SingleActionArgController(
    Future<EitherResponse<DataT>?> Function(Arg arg) repo, {
    required ActionStrategy strategy,
  }) : _controller = ConcurrentController<DataT, Arg>(
         repo: (arg) async => repo(arg!), // never be null
         strategy: strategy,
       ),
       super(SingleActionArgControllerState.init()) {
    final stream = _controller.stream;
    _subscription = stream.listen((event) {
      state = SingleActionArgControllerState(state: event.data, key: event.arg);
    });
  }

  final ConcurrentController<DataT, Arg> _controller;
  StreamSubscription? _subscription;

  void add(Arg arg) => _controller.fire(arg);

  @override
  void dispose() async {
    await _controller.close();
    await _subscription?.cancel();
    super.dispose();
  }
}
