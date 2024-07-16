import 'package:flutter_test/flutter_test.dart';
import 'package:worstmovie/domain/entities/movie.dart';

void main() {
  test('should create a Movie instance with given parameters', () {
    final tMovie = Movie(
      id: 1,
      year: 2020,
      title: 'Movie Title',
      studios: ['Studio A'],
      producers: ['Producer A'],
      winner: true,
    );

    expect(tMovie.id, 1);
    expect(tMovie.year, 2020);
    expect(tMovie.title, 'Movie Title');
    expect(tMovie.studios, ['Studio A']);
    expect(tMovie.producers, ['Producer A']);
    expect(tMovie.winner, true);
  });
}
