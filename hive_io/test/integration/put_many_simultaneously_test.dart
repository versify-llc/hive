import 'package:test/test.dart';

import 'integration.dart';

Future _performTest(bool lazy) async {
  const amount = 100;
  var box = await openBox(lazy);

  Future putEntries() async {
    for (var i = 0; i < amount; i++) {
      await box.put('key$i', 'value$i');
    }
  }

  final futures = <Future>[];
  for (var i = 0; i < 10; i++) {
    futures.add(putEntries());
  }
  await Future.wait(futures);

  box = await box.reopen();
  for (var i = 0; i < amount; i++) {
    expect(await box.get('key$i'), 'value$i');
  }
  await box.close();
}

void main() {
  group('put many entries simultaneously', () {
    test('normal box', () => _performTest(false));

    test('lazy box', () => _performTest(true));
  }, timeout: longTimeout);
}
