import 'package:hive_flutter/hive_flutter.dart';
part 'phone.g.dart';

@HiveType(typeId: 0)
class Phone {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String number;

  Phone(this.title, this.number);
}
