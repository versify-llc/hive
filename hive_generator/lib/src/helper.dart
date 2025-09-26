import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:source_gen/source_gen.dart';

final _hiveFieldChecker = const TypeChecker.typeNamed(HiveField);

class HiveFieldInfo {
  HiveFieldInfo(this.index, this.defaultValue);

  final int index;

  final DartObject? defaultValue;
}

HiveFieldInfo? getHiveFieldAnn(Element? element) {
  if (element == null) return null;

  final obj = _hiveFieldChecker.firstAnnotationOfExact(element);
  if (obj == null) return null;

  return HiveFieldInfo(
    obj.getField('index')!.toIntValue()!,
    obj.getField('defaultValue'),
  );
}

ConstructorElement getConstructor(InterfaceElement cls) {
  final constr = cls.constructors.firstWhereOrNull((it) => it.name == 'new');
  if (constr == null) {
    throw 'Provide an unnamed constructor.';
  }
  return constr;
}

void check(bool condition, Object error) {
  if (!condition) {
    // ignore: only_throw_errors
    throw error;
  }
}
