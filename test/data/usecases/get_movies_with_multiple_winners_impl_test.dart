import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:worstmovie/core/errors/failure.dart';
import 'package:worstmovie/data/repositories/movie_repository.dart';
import 'package:worstmovie/domain/entities/year_with_multiple_winner.dart';
import 'package:worstmovie/data/usecases/get_movies_with_multiple_winners_impl.dart';

@GenerateNiceMocks([MockSpec<MovieRepository>()])
import 'get_movies_with_multiple_winners_impl_test.mocks.dart';

void main() {
  late GetMoviesWithMultipleWinnersImpl usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMoviesWithMultipleWinnersImpl(mockMovieRepository);
  });

  final tYearsWithMultipleWinners = [
    YearWithMultipleWinners(year: 2020, winnerCount: 2),
  ];

  test('deve retornar uma lista de anos com múltiplos vencedores', () async {
    when(mockMovieRepository.getYearsWithMultipleWinners()).thenAnswer((_) async => Right(tYearsWithMultipleWinners));

    final result = await usecase();

    expect(result, Right(tYearsWithMultipleWinners));
    verify(mockMovieRepository.getYearsWithMultipleWinners());
    verifyNoMoreInteractions(mockMovieRepository);
  });

  test('deve retornar um erro quando a chamada ao repositório falhar', () async {
    when(mockMovieRepository.getYearsWithMultipleWinners()).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

    final result = await usecase();

    expect(result.isLeft(), true);
    verify(mockMovieRepository.getYearsWithMultipleWinners());
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
