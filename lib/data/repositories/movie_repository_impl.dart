import 'package:dartz/dartz.dart';
import 'package:worstmovie/core/http/http_client.dart';
import 'package:worstmovie/core/errors/failure.dart';
import 'package:worstmovie/data/models/movie_model.dart';
import 'package:worstmovie/data/models/year_with_multiple_winners_model.dart';
import 'package:worstmovie/data/repositories/movie_repository.dart';
import 'package:worstmovie/domain/entities/movie.dart';
import 'package:worstmovie/domain/entities/year_with_multiple_winner.dart';

class MovieRepositoryImpl implements MovieRepository {
  final HttpAdapter apiClient;

  MovieRepositoryImpl(this.apiClient);

  @override
  Future<Either<Failure, List<Movie>>> getMovies(int page, int size, {bool? winner, int? year}) async {
    try {
      final response = await apiClient.get('/movies', queryParameters: {
        'page': page,
        'size': size,
        'winner': winner,
        'year': year,
      });

      if (response.statusCode == 200) {
        return Right((response.data['content'] as List).map((json) => MovieModel.fromJson(json).toEntity()).toList());
      } else {
        return Left(ServerFailure('Failed to load movies'));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<YearWithMultipleWinners>>> getYearsWithMultipleWinners() async {
    try {
      final response = await apiClient.get('/movies?projection=years-with-multiple-winners');

      if (response.statusCode == 200) {
        return Right(
            (response.data['years'] as List).map((json) => YearWithMultipleWinnersModel.fromJson(json).toEntity()).toList());
      } else {
        return Left(ServerFailure('Failed to load years with multiple winners'));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getMoviesByYear(int year) async {
    try {
      final response = await apiClient.get('/movies', queryParameters: {
        'year': year,
        'winner': true,
      });

      if (response.statusCode == 200) {
        return Right((response.data as List).map((json) => MovieModel.fromJson(json).toEntity()).toList());
      } else {
        return Left(ServerFailure('Failed to load movies by year'));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
