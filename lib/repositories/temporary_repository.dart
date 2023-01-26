import 'package:dostavka/models/temporary_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class TemporaryRepository{
  void close();
  void log();
  Future<String> getLogStatus();
  void add(TemporaryUser temporaryUser);
  void addSolo(String text, String key);
  Future<TemporaryUser> get();
}

class HiveTemporaryRepository extends TemporaryRepository{
  static const String _boxName = "User_BOX";
  static const String _keyName0 = 'isLogged';
  static const String _keyName1 = "UserName";
  static const String _keyName2 = "UserSecName";
  static const String _keyName3 = "UserFamName";
  static const String _keyName4 = "UserPhone";
  static const String _keyName5 = "UserCity";
  static const String _keyName6 = "UserStreet";
  static const String _keyName7 = "UserBuilding";
  static const String _keyName8 = "UserBuildingAdd";
  static const String _keyName9 = "UserApartment";
  static const String _keyName10 = "UserPin";
  static const String _keyName11 = "UserPass";

  @override
  void log() async {
    Box box = Hive.isBoxOpen(_boxName) ? Hive.box(_boxName) : await Hive
        .openBox(_boxName);
    box.put(_keyName0, true);
  }

  @override
  Future<void> addSolo(String text, String key) async {
    Box box = Hive.isBoxOpen(_boxName) ? Hive.box(_boxName) : await Hive.openBox(_boxName);
    box.put(key, text);
  }

  @override
  Future<String> getLogStatus() async {
    await Hive.initFlutter();
    Box box = Hive.isBoxOpen(_boxName) ? Hive.box(_boxName) : await Hive
        .openBox(_boxName);
    return box.get(_keyName0, defaultValue: '');
  }

  @override
  void add(temporaryUser) async {
    Box box = Hive.isBoxOpen(_boxName) ? Hive.box(_boxName) : await Hive.openBox(_boxName);
    box.put(_keyName1, temporaryUser.name);
    box.put(_keyName2, temporaryUser.secName);
    box.put(_keyName3, temporaryUser.famName);
    box.put(_keyName4, temporaryUser.phone);
    box.put(_keyName5, temporaryUser.city);
    box.put(_keyName6, temporaryUser.street);
    box.put(_keyName7, temporaryUser.building);
    box.put(_keyName8, temporaryUser.buildingAdditional);
    box.put(_keyName9, temporaryUser.apartment);
    box.put(_keyName10, temporaryUser.pin!);
    box.put(_keyName11, temporaryUser.password);
  }

  @override
  Future<TemporaryUser> get() async {
    Box box = Hive.isBoxOpen(_boxName) ? Hive.box(_boxName) : await Hive
        .openBox(_boxName);
    TemporaryUser user = TemporaryUser(
      name: (box.get(_keyName1, defaultValue: _keyName1) != '')
          ? box.get(_keyName1, defaultValue: _keyName1)!
          : '-',
      secName: (box.get(_keyName2, defaultValue: _keyName2) != '')
          ? box.get(_keyName2, defaultValue: _keyName2)!
          : '-',
      famName: (box.get(_keyName3, defaultValue: _keyName3) != '')
          ? box.get(_keyName3, defaultValue: _keyName3)!
          : '-',
      phone: (box.get(_keyName4, defaultValue: _keyName4) != '')
          ? box.get(_keyName4, defaultValue: _keyName4)!
          : '-',
      city: (box.get(_keyName5, defaultValue: _keyName5) != '')
          ? box.get(_keyName5, defaultValue: _keyName5)!
          : '-',
      street: (box.get(_keyName6, defaultValue: _keyName6) != '')
          ? box.get(_keyName6, defaultValue: _keyName6)!
          : '-',
      building: (box.get(_keyName7, defaultValue: _keyName7) != '')
          ? box.get(_keyName7, defaultValue: _keyName7)!
          : '-',
      buildingAdditional: (box.get(_keyName8, defaultValue: _keyName8) != '')
          ? box.get(_keyName8, defaultValue: _keyName8)!
          : '-',
      apartment: (box.get(_keyName9, defaultValue: _keyName9) != '')
          ? box.get(_keyName9, defaultValue: _keyName9)!
          : '-',
      pin: (box.get(_keyName10, defaultValue: _keyName10) != '')
          ? box.get(_keyName10, defaultValue: _keyName10)!
          : '-',
      password: (box.get(_keyName11, defaultValue: _keyName11) != '')
          ? box.get(_keyName11, defaultValue: _keyName11)!
          : '-',
    );
    return user;
  }

  @override
  void close() async {
    if (Hive.isBoxOpen(_boxName)) {
      Box box = Hive.box(_boxName);
      var v = await box.close();
      return v;
    }
  }
}