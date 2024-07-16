import 'package:dartz/dartz.dart';
import 'package:worstmovie/domain/entities/year_with_multiple_winner.dart';
import 'package:worstmovie/core/errors/failure.dart';

abstract class GetMoviesWithMultipleWinners {
  Future<Either<Failure, List<YearWithMultipleWinners>>> call();
}
