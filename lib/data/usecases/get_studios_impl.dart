import 'package:dartz/dartz.dart';
import 'package:worstmovie/data/repositories/studio_repository.dart';
import 'package:worstmovie/domain/entities/studio.dart';
import 'package:worstmovie/core/errors/failure.dart';
import 'package:worstmovie/domain/usecases/get_studios.dart';

class GetStudiosImpl implements GetStudios {
  final StudioRepository repository;

  GetStudiosImpl(this.repository);

  @override
  Future<Either<Failure, List<Studio>>> call() async {
    return await repository.getStudios();
  }
}
