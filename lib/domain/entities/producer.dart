class Producer {
  final String producer;
  final int interval;
  final int previousWin;
  final int followingWin;

  Producer({
    required this.producer,
    required this.interval,
    required this.previousWin,
    required this.followingWin,
  });
}
