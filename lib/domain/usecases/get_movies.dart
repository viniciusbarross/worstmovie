import 'package:dartz/dartz.dart';
import 'package:worstmovie/domain/entities/movie.dart';
import 'package:worstmovie/core/errors/failure.dart';

abstract class GetMovies {
  Future<Either<Failure, List<Movie>>> call(int page, int size, {bool? winner, int? year});
}
