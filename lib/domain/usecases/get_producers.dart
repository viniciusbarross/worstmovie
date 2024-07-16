import 'package:dartz/dartz.dart';
import 'package:worstmovie/domain/entities/producer.dart';
import 'package:worstmovie/core/errors/failure.dart';

abstract class GetProducers {
  Future<Either<Failure, Map<String, List<Producer>>>> call();
}
