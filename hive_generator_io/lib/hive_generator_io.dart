import 'package:build/build.dart';
import 'package:hive_generator_io/src/type_adapter_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder getBuilder(BuilderOptions options) {
  return SharedPartBuilder([TypeAdapterGenerator()], 'hive_generator_io');
}
