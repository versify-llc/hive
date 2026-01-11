import 'package:hive_io/hive_io.dart';

/// Not part of public API
class IgnoredTypeAdapter<T> implements TypeAdapter<T?> {
  const IgnoredTypeAdapter([this.typeId = 0]);

  @override
  final int typeId;

  @override
  T? read(BinaryReader reader) => null;

  @override
  void write(BinaryWriter writer, T? obj) {}
}
