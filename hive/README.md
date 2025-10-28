# hive_lite

Hive is a lightweight and blazing fast key-value database written in pure Dart.

- 🚀 Built for mobile and desktop
- 🔒 Encryption built in
- 🎈 **NO** native dependencies

If you're looking for the features listed below, then see [hive_ce](https://pub.dev/packages/hive_ce).
- Multi-isolate support
- Web support

## Usage

You can use Hive just like a map. It is not necessary to await `Futures`.

```dart
var box = Hive.box('myBox');

box.put('name', 'David');

var name = box.get('name');

print('Name: $name');
```

## Store objects

Hive not only supports primitives, lists and maps but also any Dart object you like. You need to generate a type adapter before you can store objects.

```dart
@HiveType(typeId: 0)
class Person extends HiveObject {

  @HiveField(0)
  String name;

  @HiveField(1)
  int age;
}
```

## Hive ❤️ Flutter

Hive was written with Flutter in mind. It is a perfect fit if you need a lightweight datastore for your app. After adding the required dependencies and initializing Hive, you can use Hive in your project:

```dart
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('settings').listenable(),
      builder: (context, box, widget) {
        return Switch(
          value: box.get('darkMode'),
          onChanged: (val) {
            box.put('darkMode', val);
          }
        );
      },
    );
  }
}
```

Boxes are cached and therefore fast enough to be used directly in the `build()` method of Flutter widgets.
