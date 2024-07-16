import 'package:dartz/dartz.dart';
import 'package:worstmovie/core/http/http_client.dart';
import 'package:worstmovie/core/errors/failure.dart';
import 'package:worstmovie/data/models/studio_model.dart';
import 'package:worstmovie/data/repositories/studio_repository.dart';
import 'package:worstmovie/domain/entities/studio.dart';

class StudioRepositoryImpl implements StudioRepository {
  final HttpAdapter apiClient;

  StudioRepositoryImpl(this.apiClient);

  @override
  Future<Either<Failure, List<Studio>>> getStudios() async {
    try {
      final response = await apiClient.get('/movies', queryParameters: {
        'projection': 'studios-with-win-count',
      });

      if (response['statusCode'] == 200) {
        final List<dynamic> studiosJson = response['data']['studios'];
        return Right(studiosJson.map((json) => StudioModel.fromJson(json).toEntity()).toList());
      } else {
        return Left(ServerFailure('Failed to load studios'));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
