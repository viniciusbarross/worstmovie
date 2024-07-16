import 'package:flutter_test/flutter_test.dart';
import 'package:worstmovie/data/models/studio_model.dart';

void main() {
  final tStudioModel = StudioModel(
    name: 'Studio A',
    winCount: 10,
  );

  test('should return a valid model from JSON', () {
    final jsonMap = {
      'name': 'Studio A',
      'winCount': 10,
    };

    final result = StudioModel.fromJson(jsonMap);

    expect(result.name, tStudioModel.name);
  });

  test('should return a JSON map containing the proper data', () {
    final expectedMap = {
      'name': 'Studio A',
      'winCount': 10,
    };

    final result = tStudioModel.toJson();

    expect(result, expectedMap);
  });
}
