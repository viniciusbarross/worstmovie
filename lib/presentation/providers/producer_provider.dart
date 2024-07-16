import 'package:flutter/material.dart';
import 'package:worstmovie/core/errors/failure.dart';
import 'package:worstmovie/domain/entities/producer.dart';
import 'package:worstmovie/domain/usecases/get_producers.dart';

class ProducerProvider extends ChangeNotifier {
  final GetProducers getProducers;

  List<Producer> _maxProducers = [];
  List<Producer> _minProducers = [];
  bool _isLoading = false;
  Failure? _failure;

  ProducerProvider(this.getProducers);

  List<Producer> get maxProducers => _maxProducers;
  List<Producer> get minProducers => _minProducers;
  bool get isLoading => _isLoading;
  Failure? get failure => _failure;

  Future<void> fetchProducers() async {
    _isLoading = true;
    _failure = null;
    notifyListeners();
    final result = await getProducers();

    result.fold(
      (failure) {
        _isLoading = false;
        _failure = failure;
        notifyListeners();
      },
      (producersMap) {
        _maxProducers = producersMap['max'] ?? [];
        _minProducers = producersMap['min'] ?? [];
        _isLoading = false;
        notifyListeners();
      },
    );
  }
}
