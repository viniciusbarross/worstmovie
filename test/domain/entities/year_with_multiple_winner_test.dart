import 'package:flutter_test/flutter_test.dart';
import 'package:worstmovie/domain/entities/year_with_multiple_winner.dart';

void main() {
  test('should create a YearWithMultipleWinners instance with given parameters', () {
    final tYearWithMultipleWinners = YearWithMultipleWinners(
      year: 2020,
      winnerCount: 5,
    );

    expect(tYearWithMultipleWinners.year, 2020);
    expect(tYearWithMultipleWinners.winnerCount, 5);
  });
}
