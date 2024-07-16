import 'package:dartz/dartz.dart';
import 'package:worstmovie/core/http/http_client.dart';
import 'package:worstmovie/core/errors/failure.dart';
import 'package:worstmovie/data/models/producer_model.dart';
import 'package:worstmovie/data/repositories/producer_repository.dart';
import 'package:worstmovie/domain/entities/producer.dart';

class ProducerRepositoryImpl implements ProducerRepository {
  final HttpAdapter apiClient;

  ProducerRepositoryImpl(this.apiClient);

  @override
  Future<Either<Failure, Map<String, List<Producer>>>> getProducers() async {
    try {
      final response = await apiClient.get('/movies', queryParameters: {
        'projection': 'max-min-win-interval-for-producers',
      });

      if (response['statusCode'] == 200) {
        final List<dynamic> minProducersJson = response['data']['min'];
        final List<dynamic> maxProducersJson = response['data']['max'];
        final minProducers = minProducersJson.map((json) => ProducerModel.fromJson(json).toEntity()).toList();
        final maxProducers = maxProducersJson.map((json) => ProducerModel.fromJson(json).toEntity()).toList();
        return Right({
          'min': minProducers,
          'max': maxProducers,
        });
      } else {
        return Left(ServerFailure('Failed to load producers'));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
