import 'package:flutter_test/flutter_test.dart';
import 'package:worstmovie/data/models/producer_model.dart';
import 'package:worstmovie/domain/entities/producer.dart';

void main() {
  final tProducerModel = ProducerModel(
    producer: 'Producer A',
    interval: 5,
    previousWin: 2015,
    followingWin: 2020,
  );

  test('should return a valid model from JSON', () {
    final jsonMap = {
      'producer': 'Producer A',
      'interval': 5,
      'previousWin': 2015,
      'followingWin': 2020,
    };

    final result = ProducerModel.fromJson(jsonMap);

    expect(result.interval, tProducerModel.interval);
  });

  test('should return a JSON map containing the proper data', () {
    final expectedMap = {
      'producer': 'Producer A',
      'interval': 5,
      'previousWin': 2015,
      'followingWin': 2020,
    };

    final result = tProducerModel.toJson();

    expect(result, expectedMap);
  });
}
