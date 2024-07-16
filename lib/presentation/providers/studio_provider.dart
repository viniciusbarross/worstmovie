import 'package:flutter/material.dart';
import 'package:worstmovie/core/errors/failure.dart';
import 'package:worstmovie/domain/entities/studio.dart';
import 'package:worstmovie/domain/usecases/get_studios.dart';

class StudioProvider extends ChangeNotifier {
  final GetStudios getStudios;

  List<Studio> _studios = [];
  bool _isLoading = false;
  Failure? _failure;

  StudioProvider(this.getStudios);

  List<Studio> get studios => _studios;
  bool get isLoading => _isLoading;
  Failure? get failure => _failure;

  Future<void> fetchStudios() async {
    _isLoading = true;
    _failure = null;
    notifyListeners();
    final result = await getStudios();

    result.fold(
      (failure) {
        _isLoading = false;
        _failure = failure;
        notifyListeners();
      },
      (studios) {
        _studios = studios;
        _isLoading = false;
        notifyListeners();
      },
    );
  }
}
