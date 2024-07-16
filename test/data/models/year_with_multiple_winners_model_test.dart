import 'package:flutter_test/flutter_test.dart';
import 'package:worstmovie/data/models/year_with_multiple_winners_model.dart';

void main() {
  final tYearWithMultipleWinnersModel = YearWithMultipleWinnersModel(
    year: 2020,
    winnerCount: 5,
  );

  test('should return a valid model from JSON', () {
    final jsonMap = {
      'year': 2020,
      'winnerCount': 5,
    };

    final result = YearWithMultipleWinnersModel.fromJson(jsonMap);

    expect(result.winnerCount, tYearWithMultipleWinnersModel.winnerCount);

    expect(result.year, tYearWithMultipleWinnersModel.year);
  });
}
