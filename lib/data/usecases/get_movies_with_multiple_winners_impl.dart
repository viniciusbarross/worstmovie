import 'package:dartz/dartz.dart';
import 'package:worstmovie/data/repositories/movie_repository.dart';
import 'package:worstmovie/domain/entities/year_with_multiple_winner.dart';
import 'package:worstmovie/core/errors/failure.dart';
import 'package:worstmovie/domain/usecases/get_movies_with_multiple_winners.dart';

class GetMoviesWithMultipleWinnersImpl implements GetMoviesWithMultipleWinners {
  final MovieRepository repository;

  GetMoviesWithMultipleWinnersImpl(this.repository);

  @override
  Future<Either<Failure, List<YearWithMultipleWinners>>> call() async {
    return await repository.getYearsWithMultipleWinners();
  }
}
