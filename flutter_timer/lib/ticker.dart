class Ticker {
  Stream<int> tick({int ticks}) =>
  // x starts from 0 and incremented for every event
      Stream
      .periodic(Duration(seconds: 1), (x) => ticks - x - 1)
      .take(ticks);
}
