import 'package:flutter_test/flutter_test.dart';
import 'package:worstmovie/domain/entities/producer.dart';

void main() {
  test('should create a Producer instance with given parameters', () {
    final tProducer = Producer(
      producer: 'Producer A',
      interval: 5,
      previousWin: 2010,
      followingWin: 2015,
    );

    expect(tProducer.producer, 'Producer A');
    expect(tProducer.interval, 5);
    expect(tProducer.previousWin, 2010);
    expect(tProducer.followingWin, 2015);
  });
}
