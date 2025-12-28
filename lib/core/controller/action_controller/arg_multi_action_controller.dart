part of 'action_controllers.dart';

class ArgMultiCommandState<DataT, Arg extends Record> {
  const ArgMultiCommandState(this._eventsRef);
  const ArgMultiCommandState.init() : _eventsRef = const {};
  Map<Arg, AsyncState<DataT>> get events {
    final Map<Arg, AsyncState<DataT>> result = {};
    for (final entry in _eventsRef.entries) {
      result[entry.value.arg] = entry.value.data;
    }

    return result;
  }

  AsyncState<DataT> where(bool Function(Arg arg) values) {
    final event = events.entries.firstWhereOrNull((entry) => values(entry.key));

    // If event not exist.
    if (event == null) return Init<DataT>();

    return event.value;
  }

  bool get hasLoaded => events.values.whereType<Loaded<DataT>>().isNotEmpty;

  final Map<MemoryUniqueId, ({Arg arg, AsyncState<DataT> data})> _eventsRef;
}

class ArgMultiCommand<DataT, Arg extends Record>
    extends StateNotifier<ArgMultiCommandState<DataT, Arg>> {
  ArgMultiCommand(
    Future<EitherResponse<DataT>?> Function(Arg arg) repo, {
    required ActionStrategy strategy,
  }) : _controller =
           ConcurrentController<DataT, ({Arg arg, MemoryUniqueId uniqKey})>(
             repo: (arg) async => repo(arg!.arg),
             strategy: strategy,
           ),
       super(ArgMultiCommandState<DataT, Arg>.init()) {
    final stream = _controller.stream;
    _subscription = stream.listen((data) {
      final currentEvents = {...state._eventsRef};

      if (data.data.isInit && currentEvents.containsKey(data.arg!.uniqKey)) {
        currentEvents.remove(data.arg!.uniqKey);
      } else {
        currentEvents[data.arg!.uniqKey] = (
          arg: data.arg!.arg,
          data: data.data,
        );
      }

      state = ArgMultiCommandState<DataT, Arg>(currentEvents);
    });
  }

  final ConcurrentController<DataT, ({Arg arg, MemoryUniqueId uniqKey})>
  _controller;
  StreamSubscription? _subscription;

  void add(Arg arg) async {
    if (state.events.containsKey(arg)) return;
    const uniqKey = MemoryUniqueId();
    state = ArgMultiCommandState<DataT, Arg>({
      ...state._eventsRef,
      uniqKey: (arg: arg, data: Init<DataT>()),
    });
    _controller.fire((arg: arg, uniqKey: uniqKey));
  }

  @override
  void dispose() async {
    await _subscription?.cancel();
    await _controller.close();
    super.dispose();
  }
}

class MemoryUniqueId {
  const MemoryUniqueId();
}
