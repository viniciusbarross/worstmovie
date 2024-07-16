import 'package:flutter_test/flutter_test.dart';
import 'package:worstmovie/core/errors/failure.dart';

void main() {
  test('ServerFailure should have a message', () {
    final failure = ServerFailure('Server error');
    expect(failure.message, 'Server error');
  });

  test('NotFoundFailure should have a message', () {
    final failure = NotFoundFailure('Not found');
    expect(failure.message, 'Not found');
  });

  test('UnknownFailure should have a message', () {
    final failure = UnknownFailure('Unknown error');
    expect(failure.message, 'Unknown error');
  });
}
