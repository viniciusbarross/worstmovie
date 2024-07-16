import 'package:flutter_test/flutter_test.dart';
import 'package:worstmovie/domain/entities/studio.dart';

void main() {
  test('should create a Studio instance with given parameters', () {
    final tStudio = Studio(
      name: 'Studio A',
      winCount: 10,
    );

    expect(tStudio.name, 'Studio A');
    expect(tStudio.winCount, 10);
  });
}
