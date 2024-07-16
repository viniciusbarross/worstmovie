import 'package:dartz/dartz.dart';
import 'package:worstmovie/core/errors/failure.dart';
import 'package:worstmovie/domain/entities/movie.dart';
import 'package:worstmovie/domain/entities/year_with_multiple_winner.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getMovies(int page, int size, {bool? winner, int? year});
  Future<Either<Failure, List<YearWithMultipleWinners>>> getYearsWithMultipleWinners();
  Future<Either<Failure, List<Movie>>> getMoviesByYear(int year);
}
