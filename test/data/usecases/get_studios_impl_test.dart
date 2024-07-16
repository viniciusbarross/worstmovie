import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:worstmovie/core/errors/failure.dart';
import 'package:worstmovie/data/repositories/studio_repository.dart';
import 'package:worstmovie/domain/entities/studio.dart';
import 'package:worstmovie/data/usecases/get_studios_impl.dart';

@GenerateNiceMocks([MockSpec<StudioRepository>()])
import 'get_studios_impl_test.mocks.dart';

void main() {
  late GetStudiosImpl usecase;
  late MockStudioRepository mockStudioRepository;

  setUp(() {
    mockStudioRepository = MockStudioRepository();
    usecase = GetStudiosImpl(mockStudioRepository);
  });

  final tStudios = [
    Studio(
      name: 'Studio A',
      winCount: 3,
    ),
    Studio(
      name: 'Studio B',
      winCount: 5,
    ),
  ];

  test('deve retornar uma lista de estúdios', () async {
    when(mockStudioRepository.getStudios()).thenAnswer((_) async => Right(tStudios));

    final result = await usecase();

    expect(result, Right(tStudios));
    verify(mockStudioRepository.getStudios());
    verifyNoMoreInteractions(mockStudioRepository);
  });

  test('deve retornar um erro quando a chamada ao repositório falhar', () async {
    when(mockStudioRepository.getStudios()).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

    final result = await usecase();

    expect(result.isLeft(), true);
    verify(mockStudioRepository.getStudios());
    verifyNoMoreInteractions(mockStudioRepository);
  });
}
