import 'package:hive/hive.dart';

Future<Box> openBox(String boxName) async {
  return await Hive.openBox(boxName);
}

Box getBox(String boxName) {
  return Hive.box(boxName);
}
