import 'builder.dart';
import 'helper.dart';

class EnumBuilder extends Builder {
  EnumBuilder(super.cls, super.getters);

  @override
  String buildRead() {
    check(
        getters.isNotEmpty, '${cls.displayName} does not have any enum value.');

    final code = StringBuffer();
    code.writeln('switch (reader.readByte()) {');

    for (final field in getters) {
      code.writeln('''
        case ${field.index}:
          return ${cls.displayName}.${field.name};''');
    }

    final defaultField = getters.firstWhere(
      (it) => it.defaultValue?.toBoolValue() == true,
      orElse: () => getters.first,
    );
    code.writeln('''
      default:
        return ${cls.displayName}.${defaultField.name};
      }''');

    return code.toString();
  }

  @override
  String buildWrite() {
    final code = StringBuffer();
    code.writeln('switch (obj) {');

    for (final field in getters) {
      code.writeln('''
        case ${cls.displayName}.${field.name}:
          writer.writeByte(${field.index});
          break;''');
    }

    code.writeln('}');

    return code.toString();
  }
}
