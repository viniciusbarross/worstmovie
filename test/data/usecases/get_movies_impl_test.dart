import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:worstmovie/core/errors/failure.dart';
import 'package:worstmovie/data/repositories/movie_repository.dart';
import 'package:worstmovie/domain/entities/movie.dart';
import 'package:worstmovie/data/usecases/get_movies_impl.dart';

@GenerateNiceMocks([MockSpec<MovieRepository>()])
import 'get_movies_impl_test.mocks.dart';

void main() {
  late GetMoviesImpl usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMoviesImpl(mockMovieRepository);
  });

  const tPage = 1;
  const tSize = 10;
  final tMovies = [
    Movie(
      id: 1,
      title: 'Movie 1',
      year: 2020,
      studios: ['Studio A'],
      producers: ['Producer A'],
      winner: true,
    ),
  ];

  test('deve retornar uma lista de filmes para a página e tamanho fornecidos', () async {
    when(mockMovieRepository.getMovies(any, any, winner: anyNamed('winner'), year: anyNamed('year')))
        .thenAnswer((_) async => Right(tMovies));

    final result = await usecase(tPage, tSize);

    expect(result, Right(tMovies));
    verify(mockMovieRepository.getMovies(tPage, tSize));
    verifyNoMoreInteractions(mockMovieRepository);
  });

  test('deve retornar um erro quando a chamada ao repositório falhar', () async {
    when(mockMovieRepository.getMovies(any, any, winner: anyNamed('winner'), year: anyNamed('year')))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

    final result = await usecase(tPage, tSize);

    expect(result.isLeft(), true);
    verify(mockMovieRepository.getMovies(tPage, tSize));
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
