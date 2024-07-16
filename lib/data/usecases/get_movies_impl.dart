import 'package:dartz/dartz.dart';
import 'package:worstmovie/data/repositories/movie_repository.dart';
import 'package:worstmovie/domain/entities/movie.dart';
import 'package:worstmovie/core/errors/failure.dart';
import 'package:worstmovie/domain/usecases/get_movies.dart';

class GetMoviesImpl implements GetMovies {
  final MovieRepository repository;

  GetMoviesImpl(this.repository);

  @override
  Future<Either<Failure, List<Movie>>> call(int page, int size, {bool? winner, int? year}) {
    return repository.getMovies(page, size, winner: winner, year: year);
  }
}
