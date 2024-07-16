import 'package:dartz/dartz.dart';
import 'package:worstmovie/core/errors/failure.dart';
import 'package:worstmovie/domain/entities/producer.dart';

abstract class ProducerRepository {
  Future<Either<Failure, Map<String, List<Producer>>>> getProducers();
}
