import 'package:worstmovie/domain/entities/year_with_multiple_winner.dart';

class YearWithMultipleWinnersModel {
  final int year;
  final int winnerCount;

  YearWithMultipleWinnersModel({
    required this.year,
    required this.winnerCount,
  });

  factory YearWithMultipleWinnersModel.fromJson(Map<String, dynamic> json) {
    return YearWithMultipleWinnersModel(
      year: json['year'],
      winnerCount: json['winnerCount'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'winnerCount': winnerCount,
    };
  }

  YearWithMultipleWinners toEntity() {
    return YearWithMultipleWinners(
      year: year,
      winnerCount: winnerCount,
    );
  }
}
