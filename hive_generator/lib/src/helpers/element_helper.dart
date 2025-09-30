import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:source_gen/source_gen.dart';

const _hiveFieldChecker = TypeChecker.typeNamed(HiveField);

/// [_HiveFieldInfo] stores the annotation data for each Hive field
class _HiveFieldInfo {
  _HiveFieldInfo(this.index, this.defaultValue);

  final int index;

  final DartObject? defaultValue;
}

_HiveFieldInfo? getHiveFieldAnnotation(Element? element) {
  if (element == null) return null;

  final obj = _hiveFieldChecker.firstAnnotationOfExact(element);
  if (obj == null) return null;

  return _HiveFieldInfo(
    obj.getField('index')!.toIntValue()!,
    obj.getField('defaultValue'),
  );
}

// Find default (unnamed) constructor in Hive class
ConstructorElement getConstructor(InterfaceElement cls) {
  final constr = cls.constructors.firstWhereOrNull((it) => it.name == 'new');

  if (constr == null) {
    throw 'Provide an unnamed constructor.';
  }

  return constr;
}
