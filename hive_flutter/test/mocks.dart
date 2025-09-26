import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';

export 'mocks.mocks.dart';

@GenerateMocks(
  [],
  customMocks: [
    MockSpec<BinaryReader>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<BinaryWriter>(onMissingStub: OnMissingStub.returnDefault),
  ],
)
// ignore: unused_element
late dynamic _mocks;
