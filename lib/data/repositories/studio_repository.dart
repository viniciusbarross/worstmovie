import 'package:dartz/dartz.dart';
import 'package:worstmovie/core/errors/failure.dart';
import 'package:worstmovie/domain/entities/studio.dart';

abstract class StudioRepository {
  Future<Either<Failure, List<Studio>>> getStudios();
}
