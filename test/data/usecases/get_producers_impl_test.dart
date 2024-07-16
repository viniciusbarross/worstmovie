import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:worstmovie/core/errors/failure.dart';
import 'package:worstmovie/data/repositories/producer_repository.dart';
import 'package:worstmovie/domain/entities/producer.dart';
import 'package:worstmovie/data/usecases/get_producers_impl.dart';

@GenerateNiceMocks([MockSpec<ProducerRepository>()])
import 'get_producers_impl_test.mocks.dart';

void main() {
  late GetProducersImpl usecase;
  late MockProducerRepository mockProducerRepository;

  setUp(() {
    mockProducerRepository = MockProducerRepository();
    usecase = GetProducersImpl(mockProducerRepository);
  });

  final tProducers = {
    'min': [
      Producer(
        producer: 'Producer A',
        interval: 1,
        previousWin: 2000,
        followingWin: 2001,
      ),
    ],
    'max': [
      Producer(
        producer: 'Producer B',
        interval: 10,
        previousWin: 1990,
        followingWin: 2000,
      ),
    ],
  };

  test('deve retornar um mapa de produtores com os intervalos mínimo e máximo', () async {
    when(mockProducerRepository.getProducers()).thenAnswer((_) async => Right(tProducers));

    final result = await usecase();

    expect(result, Right(tProducers));
    verify(mockProducerRepository.getProducers());
    verifyNoMoreInteractions(mockProducerRepository);
  });

  test('deve retornar um erro quando a chamada ao repositório falhar', () async {
    when(mockProducerRepository.getProducers()).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

    final result = await usecase();

    expect(result.isLeft(), true);
    verify(mockProducerRepository.getProducers());
    verifyNoMoreInteractions(mockProducerRepository);
  });
}
