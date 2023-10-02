import 'package:flutter/material.dart';
import 'package:opening_the_entrance/models/phone.dart';

import '../core/hive_helper.dart';

class PhoneList extends ChangeNotifier{

  static List<Phone> _items = [];

  List<Phone> get items {
    return _items;
  }

  Future<void> addListPhone(String title, String number) async {
    final newPhone = Phone(title, number);
    _items.add(newPhone);
    (await HiveHelper.getDB<Phone>('list_access')).add(newPhone);
    notifyListeners();
  }
  Future<void> fetchAndSetListPhone()async {
    _items = (await HiveHelper.getDB<Phone>('list_access'))
        .values.toList();
  }

  Future<void> deletePhone(Phone phone)async {
    var db = await HiveHelper.getDB<Phone>('list_access');
    if(_items.contains(phone)){
      db.deleteAt(_items.indexOf(phone));
      _items.remove(phone);
    }
    notifyListeners();
  }
}