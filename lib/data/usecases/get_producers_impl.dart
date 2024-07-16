import 'package:dartz/dartz.dart';
import 'package:worstmovie/data/repositories/producer_repository.dart';
import 'package:worstmovie/domain/entities/producer.dart';
import 'package:worstmovie/core/errors/failure.dart';
import 'package:worstmovie/domain/usecases/get_producers.dart';

class GetProducersImpl implements GetProducers {
  final ProducerRepository repository;

  GetProducersImpl(this.repository);

  @override
  Future<Either<Failure, Map<String, List<Producer>>>> call() async {
    return await repository.getProducers();
  }
}
