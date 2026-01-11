# hive_io

Hive is a lightweight and blazing fast key-value database written in pure Dart.

- 🚀 Built for mobile and desktop
- 🔒 Encryption built in
- 🎈 No native dependencies

👉 The original maintainer of Hive has abandoned the project. This is a clone (minus web support) to keep packages up-to-date. I'm not planning to add any new features because my goal is to just keep Hive working as-is. Checkout [hive_ce](https://pub.dev/packages/hive_ce) if you're looking for any of these things:

- Multi-isolate support
- Web support
- New feature development

## Getting started

Follow this guide to setup Hive in your Flutter project.

### Install dependencies

Add these packages as dependencies in your `pubspec.yaml`:

```yaml
  hive:
    git:
      url: https://github.com/versify-llc/hive
      path: hive
  hive_flutter:
    git:
      url: https://github.com/versify-llc/hive
      path: hive_flutter
```

Add `hive_generator` to your `dev_dependencies`:

```yaml
  hive_generator:
    git:
      url: https://github.com/versify-llc/hive
      path: hive_generator
```

### Generate Hive types

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

Run build_runner to generate types:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Initialize Hive

Initialize hive in your `main.dart` 

```dart
await Hive.initFlutter(null);
Hive.registerAdapter(PersonAdapter());
final personBox = await Hive.openBox<Person>('person');
```

### Interacting with Hive

You can use Hive just like a map. It is not necessary to await Futures.

```dart
var box = Hive.box('person');

box.put('name', 'David');

var name = box.get('name');

print('Name: $name');
```

### Listen to object updates

Use `ValueListenableBuilder` to listen for data changes to a box and update your widgets.

Boxes are cached and therefore fast enough to be used directly in the `build()` method of Flutter widgets.


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
