import 'package:get_it/get_it.dart';
import 'package:worstmovie/core/http/dio_adapter.dart';
import 'package:worstmovie/core/http/http_client.dart';
import 'package:worstmovie/data/repositories/movie_repository.dart';
import 'package:worstmovie/data/repositories/movie_repository_impl.dart';
import 'package:worstmovie/data/repositories/producer_repository.dart';
import 'package:worstmovie/data/repositories/studio_repository.dart';
import 'package:worstmovie/data/repositories/studio_repository_impl.dart';
import 'package:worstmovie/data/repositories/producer_repository_impl.dart';
import 'package:worstmovie/data/usecases/get_movies_by_year_impl.dart';
import 'package:worstmovie/data/usecases/get_movies_impl.dart';
import 'package:worstmovie/data/usecases/get_movies_with_multiple_winners_impl.dart';
import 'package:worstmovie/data/usecases/get_producers_impl.dart';
import 'package:worstmovie/data/usecases/get_studios_impl.dart';
import 'package:worstmovie/domain/usecases/get_movies.dart';
import 'package:worstmovie/domain/usecases/get_studios.dart';
import 'package:worstmovie/domain/usecases/get_producers.dart';
import 'package:worstmovie/domain/usecases/get_movies_with_multiple_winners.dart';
import 'package:worstmovie/domain/usecases/get_movies_by_year.dart';
import 'package:worstmovie/presentation/providers/movie_provider.dart';
import 'package:worstmovie/presentation/providers/studio_provider.dart';
import 'package:worstmovie/presentation/providers/producer_provider.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<HttpAdapter>(() => HttpDio());

  locator.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(locator.get<HttpAdapter>()));
  locator.registerLazySingleton<StudioRepository>(() => StudioRepositoryImpl(locator.get<HttpAdapter>()));
  locator.registerLazySingleton<ProducerRepository>(() => ProducerRepositoryImpl(locator.get<HttpAdapter>()));

  locator.registerLazySingleton<GetMovies>(() => GetMoviesImpl(locator.get<MovieRepository>()));
  locator.registerLazySingleton<GetMoviesWithMultipleWinners>(
      () => GetMoviesWithMultipleWinnersImpl(locator.get<MovieRepository>()));
  locator.registerLazySingleton<GetMoviesByYear>(() => GetMoviesByYearImpl(locator.get<MovieRepository>()));
  locator.registerLazySingleton<GetStudios>(() => GetStudiosImpl(locator.get<StudioRepository>()));
  locator.registerLazySingleton<GetProducers>(() => GetProducersImpl(locator.get<ProducerRepository>()));

  locator.registerFactory(
      () => MovieProvider(locator.get<GetMovies>(), locator.get<GetMoviesWithMultipleWinners>(), locator.get<GetMoviesByYear>()));
  locator.registerFactory(() => StudioProvider(locator.get<GetStudios>()));
  locator.registerFactory(() => ProducerProvider(locator.get<GetProducers>()));
}
