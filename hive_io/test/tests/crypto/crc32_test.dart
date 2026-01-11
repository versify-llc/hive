import 'dart:typed_data';

import 'package:hive_io/src/crypto/crc32.dart';
import 'package:test/test.dart';

void main() {
  group('Crc32', () {
    test('compute', () {
      expect(crc32Compute(Uint8List(0)), equals(0));
      expect(
        crc32Compute(Uint8List.fromList('123456789'.codeUnits)),
        0xcbf43926,
      );

      final crc = crc32Compute(Uint8List.fromList('12345'.codeUnits));
      expect(
        crc32Compute(Uint8List.fromList('6789'.codeUnits), crc: crc),
        equals(0xcbf43926),
      );
    });
  });
}
