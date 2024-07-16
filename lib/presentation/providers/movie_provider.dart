import 'package:flutter/material.dart';
import 'package:worstmovie/core/errors/failure.dart';
import 'package:worstmovie/domain/entities/movie.dart';
import 'package:worstmovie/domain/entities/year_with_multiple_winner.dart';
import 'package:worstmovie/domain/usecases/get_movies.dart';
import 'package:worstmovie/domain/usecases/get_movies_by_year.dart';
import 'package:worstmovie/domain/usecases/get_movies_with_multiple_winners.dart';

class MovieProvider extends ChangeNotifier {
  bool hasFetchedMoviesWithMultipleWinners = false;

  final GetMovies getMovies;
  final GetMoviesWithMultipleWinners getMoviesWithMultipleWinners;
  final GetMoviesByYear getMoviesByYear;

  List<Movie> _movies = [];
  List<YearWithMultipleWinners> _yearsWithMultipleWinners = [];
  List<Movie> _moviesByYear = [];
  bool _isLoading = false;
  Failure? _failure;

  MovieProvider(this.getMovies, this.getMoviesWithMultipleWinners, this.getMoviesByYear);

  List<Movie> get movies => _movies;
  List<YearWithMultipleWinners> get yearsWithMultipleWinners => _yearsWithMultipleWinners;
  List<Movie> get moviesByYear => _moviesByYear;

  bool get isLoading => _isLoading;
  Failure? get failure => _failure;

  Future<void> fetchMovies(int page, int size, {bool? winner, int? year}) async {
    _isLoading = true;
    _failure = null;
    notifyListeners();

    final result = await getMovies(page, size, winner: winner, year: year);

    result.fold(
      (failure) {
        _isLoading = false;
        _failure = failure;
        notifyListeners();
      },
      (movies) {
        _movies = movies;
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> fetchMoviesWithMultipleWinners() async {
    if (hasFetchedMoviesWithMultipleWinners) return;
    _isLoading = true;
    _failure = null;
    notifyListeners();

    final result = await getMoviesWithMultipleWinners();

    result.fold(
      (failure) {
        _isLoading = false;
        _failure = failure;
        notifyListeners();
      },
      (years) {
        hasFetchedMoviesWithMultipleWinners = true;
        _yearsWithMultipleWinners = years;
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> fetchMoviesByYear(int year) async {
    _isLoading = true;
    _failure = null;
    notifyListeners();

    final result = await getMoviesByYear(year);

    result.fold(
      (failure) {
        _isLoading = false;
        _failure = failure;
        notifyListeners();
      },
      (movies) {
        _moviesByYear = movies;
        _isLoading = false;
        notifyListeners();
      },
    );
  }
}
