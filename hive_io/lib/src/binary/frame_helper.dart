import 'dart:typed_data';

import 'package:hive_io/hive_io.dart';
import 'package:hive_io/src/binary/binary_reader_impl.dart';
import 'package:hive_io/src/box/keystore.dart';

/// Not part of public API
class FrameHelper {
  /// Not part of public API
  int framesFromBytes(
    Uint8List bytes,
    Keystore? keystore,
    TypeRegistry registry,
    HiveCipher? cipher,
  ) {
    final reader = BinaryReaderImpl(bytes, registry);

    while (reader.availableBytes != 0) {
      final frameOffset = reader.usedBytes;

      final frame = reader.readFrame(cipher: cipher, frameOffset: frameOffset);
      if (frame == null) return frameOffset;

      keystore!.insert(frame, notify: false);
    }

    return -1;
  }
}
