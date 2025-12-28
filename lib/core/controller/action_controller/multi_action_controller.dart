part of 'action_controllers.dart';

class MultiCommandState<DataT> extends Equatable {
  const MultiCommandState(this._eventsRef);
  const MultiCommandState.init() : _eventsRef = const {};
  List<AsyncState<DataT>> get events => _eventsRef.values.toList();
  final Map<({MemoryUniqueId uniqKey}), AsyncState<DataT>> _eventsRef;

  @override
  List<Object?> get props => [_eventsRef];
}

class MultiCommand<DataT> extends StateNotifier<MultiCommandState<DataT>> {
  MultiCommand(FutureRepoResult<DataT> repo, {required ActionStrategy strategy})
    : _controller = ConcurrentController<DataT, ({MemoryUniqueId uniqKey})>(
        repo: (_) => repo(),
        strategy: strategy,
      ),
      super(MultiCommandState<DataT>.init()) {
    final stream = _controller.stream;
    _subscription = stream.listen((event) {
      final currentEvents = {...state._eventsRef};
      if (event.data.isInit && currentEvents.containsKey(event.arg)) {
        currentEvents.remove(event.arg);
      } else {
        currentEvents[event.arg!] = event.data;
      }
      state = MultiCommandState(currentEvents);
    });
  }

  final ConcurrentController<DataT, ({MemoryUniqueId uniqKey})> _controller;
  StreamSubscription? _subscription;

  void add() async {
    const uniqKey = MemoryUniqueId();

    state = MultiCommandState({
      ...state._eventsRef,
      (uniqKey: uniqKey): Init<DataT>(),
    });
    _controller.fire((uniqKey: uniqKey));
  }

  @override
  void dispose() async {
    await _subscription?.cancel();
    await _controller.close();
    super.dispose();
  }
}
