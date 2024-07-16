import 'package:dartz/dartz.dart';
import 'package:worstmovie/domain/entities/studio.dart';
import 'package:worstmovie/core/errors/failure.dart';

abstract class GetStudios {
  Future<Either<Failure, List<Studio>>> call();
}
