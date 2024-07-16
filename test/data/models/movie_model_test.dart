import 'package:flutter_test/flutter_test.dart';
import 'package:worstmovie/data/models/movie_model.dart';
import 'package:worstmovie/domain/entities/movie.dart';

void main() {
  final tMovieModel = MovieModel(
    id: 1,
    year: 2020,
    title: 'Movie 1',
    studios: ['Studio A'],
    producers: ['Producer A'],
    winner: true,
  );

  test('should return a valid model from JSON', () {
    final jsonMap = {
      'id': 1,
      'year': 2020,
      'title': 'Movie 1',
      'studios': ['Studio A'],
      'producers': ['Producer A'],
      'winner': true,
    };

    final result = MovieModel.fromJson(jsonMap);

    expect(result.id, tMovieModel.id);
  });

  test('should return a JSON map containing the proper data', () {
    final expectedMap = {
      'id': 1,
      'year': 2020,
      'title': 'Movie 1',
      'studios': ['Studio A'],
      'producers': ['Producer A'],
      'winner': true,
    };

    final result = tMovieModel.toJson();

    expect(result, expectedMap);
  });
}
