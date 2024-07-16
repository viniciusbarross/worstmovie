import 'package:dartz/dartz.dart';
import 'package:worstmovie/data/repositories/movie_repository.dart';
import 'package:worstmovie/domain/entities/movie.dart';
import 'package:worstmovie/core/errors/failure.dart';
import 'package:worstmovie/domain/usecases/get_movies_by_year.dart';

class GetMoviesByYearImpl implements GetMoviesByYear {
  final MovieRepository repository;

  GetMoviesByYearImpl(this.repository);

  @override
  Future<Either<Failure, List<Movie>>> call(int year) async {
    return await repository.getMoviesByYear(year);
  }
}
