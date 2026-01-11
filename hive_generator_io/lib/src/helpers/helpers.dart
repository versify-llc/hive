export './element_helper.dart';
export './type_helper.dart';

// Similar to `assert` but works in PROD
void check(bool condition, Object error) {
  if (!condition) {
    throw error;
  }
}
