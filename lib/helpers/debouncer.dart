import 'dart:async';

class Debouncer {
  final int milliseconds;
  Timer? _timer;
  Debouncer({required this.milliseconds});
  void run(void Function() action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  T? runWithPossibleResult<T, G>(
      T Function<T, G>(G? genericInput)? callbackAfterDebouncing,
      G? genericInput) {
    return callbackAfterDebouncing!(genericInput);
  }

  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }
}