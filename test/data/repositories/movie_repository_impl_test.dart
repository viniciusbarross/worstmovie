import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:worstmovie/core/errors/failure.dart';
import 'package:worstmovie/core/http/http_client.dart';
import 'package:worstmovie/data/models/movie_model.dart';
import 'package:worstmovie/data/models/year_with_multiple_winners_model.dart';
import 'package:worstmovie/data/repositories/movie_repository_impl.dart';
import 'package:worstmovie/domain/entities/movie.dart';
import 'package:worstmovie/domain/entities/year_with_multiple_winner.dart';
@GenerateNiceMocks([MockSpec<HttpAdapter>()])
import 'movie_repository_impl_test.mocks.dart';

void main() {
  late MovieRepositoryImpl repository;
  late MockHttpAdapter mockHttpAdapter;

  setUp(() {
    mockHttpAdapter = MockHttpAdapter();
    repository = MovieRepositoryImpl(mockHttpAdapter);
  });

  final tMovies = [
    MovieModel(
      id: 1,
      year: 2020,
      title: 'Movie 1',
      studios: ['Studio A'],
      producers: ['Producer A'],
      winner: true,
    ),
  ];
  const tYear = 2020;

  test('deve retornar uma lista de filmes', () async {
    when(mockHttpAdapter.get('/movies', queryParameters: anyNamed('queryParameters'))).thenAnswer((_) async {
      return {
        'statusCode': 200,
        'data': {
          'content': tMovies.map((m) => m.toJson()).toList(),
        },
      };
    });

    final result = await repository.getMovies(1, 10);

    expect(true, result.isRight());
  });

  test('deve retornar filmes por ano', () async {
    when(mockHttpAdapter.get('/movies', queryParameters: {
      'year': tYear,
      'winner': true,
    })).thenAnswer((_) async => {
          'statusCode': 200,
          'data': tMovies.map((m) => m.toJson()).toList(),
        });

    final result = await repository.getMoviesByYear(tYear);

    expect(result.isRight(), true);
  });

  test('deve retornar um erro ao buscar filmes por ano', () async {
    when(mockHttpAdapter.get('/movies', queryParameters: {
      'year': tYear,
      'winner': true,
    })).thenThrow(Exception('Erro'));

    final result = await repository.getMoviesByYear(tYear);

    expect(result, isA<Left<Failure, List<Movie>>>());
    verify(mockHttpAdapter.get('/movies', queryParameters: {
      'year': tYear,
      'winner': true,
    }));
  });

  test('deve retornar anos com múltiplos vencedores', () async {
    final tYearsWithMultipleWinners = [
      YearWithMultipleWinnersModel(year: 2020, winnerCount: 2),
    ];

    when(mockHttpAdapter.get('/movies?projection=years-with-multiple-winners')).thenAnswer((_) async {
      return {
        'statusCode': 200,
        'data': {
          'years': tYearsWithMultipleWinners.map((m) => m.toJson()).toList(),
        },
      };
    });

    final result = await repository.getYearsWithMultipleWinners();

    expect(result.isRight(), true);
  });

  test('deve retornar um erro ao buscar anos com múltiplos vencedores', () async {
    when(mockHttpAdapter.get('/movies?projection=years-with-multiple-winners')).thenThrow(Exception('Erro'));

    final result = await repository.getYearsWithMultipleWinners();

    expect(result, isA<Left<Failure, List<YearWithMultipleWinners>>>());
    verify(mockHttpAdapter.get('/movies?projection=years-with-multiple-winners'));
  });
}
