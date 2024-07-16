import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:worstmovie/core/errors/failure.dart';
import 'package:worstmovie/core/http/http_client.dart';
import 'package:worstmovie/data/models/producer_model.dart';
import 'package:worstmovie/data/repositories/producer_repository_impl.dart';
import 'package:worstmovie/domain/entities/producer.dart';

import 'producer_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HttpAdapter>()])
void main() {
  late ProducerRepositoryImpl repository;
  late MockHttpAdapter mockHttpAdapter;

  setUp(() {
    mockHttpAdapter = MockHttpAdapter();
    repository = ProducerRepositoryImpl(mockHttpAdapter);
  });

  final tMinProducers = [
    Producer(
      producer: 'Producer A',
      interval: 1,
      previousWin: 2000,
      followingWin: 2001,
    ),
  ];

  final tMaxProducers = [
    Producer(
      producer: 'Producer B',
      interval: 10,
      previousWin: 1990,
      followingWin: 2000,
    ),
  ];

  test('deve retornar um mapa de produtores com intervalos mínimos e máximos', () async {
    when(mockHttpAdapter.get('/movies', queryParameters: {'projection': 'max-min-win-interval-for-producers'}))
        .thenAnswer((_) async => {
              'statusCode': 200,
              'data': {
                'min': tMinProducers.map((p) => ProducerModel.fromEntity(p).toJson()).toList(),
                'max': tMaxProducers.map((p) => ProducerModel.fromEntity(p).toJson()).toList(),
              },
            });

    final result = await repository.getProducers();

    expect(result.isRight(), true);
  });

  test('deve retornar um erro se a requisição falhar', () async {
    when(mockHttpAdapter.get('/movies', queryParameters: {'projection': 'max-min-win-interval-for-producers'}))
        .thenThrow(Exception('Erro'));

    final result = await repository.getProducers();

    expect(result, isA<Left<Failure, Map<String, List<Producer>>>>());
  });

  test('deve retornar ServerFailure quando a resposta não é 200', () async {
    when(mockHttpAdapter.get('/movies', queryParameters: {'projection': 'max-min-win-interval-for-producers'}))
        .thenAnswer((_) async => {
              'statusCode': 404,
            });

    final result = await repository.getProducers();

    expect(result.isLeft(), true);
  });
}
