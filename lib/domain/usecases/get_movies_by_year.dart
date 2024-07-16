import 'package:dartz/dartz.dart';
import 'package:worstmovie/domain/entities/movie.dart';
import 'package:worstmovie/core/errors/failure.dart';

abstract class GetMoviesByYear {
  Future<Either<Failure, List<Movie>>> call(int year);
}
