import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:worstmovie/core/errors/failure.dart';
import 'package:worstmovie/core/http/http_client.dart';
import 'package:worstmovie/data/models/studio_model.dart';
import 'package:worstmovie/data/repositories/studio_repository_impl.dart';
import 'package:worstmovie/domain/entities/studio.dart';

import 'studio_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HttpAdapter>()])
void main() {
  late StudioRepositoryImpl repository;
  late MockHttpAdapter mockHttpAdapter;

  setUp(() {
    mockHttpAdapter = MockHttpAdapter();
    repository = StudioRepositoryImpl(mockHttpAdapter);
  });

  final tStudios = [
    Studio(
      name: 'Studio A',
      winCount: 5,
    ),
    Studio(
      name: 'Studio B',
      winCount: 3,
    ),
  ];

  test('deve retornar uma lista de estúdios', () async {
    when(mockHttpAdapter.get('/movies', queryParameters: {'projection': 'studios-with-win-count'})).thenAnswer((_) async => {
          'statusCode': 200,
          'data': {
            'studios': tStudios.map((s) => StudioModel.fromEntity(s).toJson()).toList(),
          },
        });

    final result = await repository.getStudios();

    expect(result.isRight(), true);
  });

  test('deve retornar um erro se a requisição falhar', () async {
    when(mockHttpAdapter.get('/movies', queryParameters: {'projection': 'studios-with-win-count'})).thenThrow(Exception('Erro'));

    final result = await repository.getStudios();

    expect(result, isA<Left<Failure, List<Studio>>>());
  });

  test('deve retornar ServerFailure quando a resposta não é 200', () async {
    when(mockHttpAdapter.get('/movies', queryParameters: {'projection': 'studios-with-win-count'})).thenAnswer((_) async => {
          'statusCode': 404,
        });

    final result = await repository.getStudios();

    expect(result.isLeft(), true);
  });
}
