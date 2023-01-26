import 'package:dostavka/models/hive_connection/boxes.dart';
import 'package:dostavka/models/hive_connection/rep_data.dart';
import 'package:hive/hive.dart';

//
class Getters {
  static Box<User> getUser() => Hive.box<User>('user');
  static Box<Address> getAddress() => Hive.box<Address>('address');
  static Box<Auth> getAuth() => Hive.box<Auth>('auth');
  static Box<Cargo> getCargo() => Hive.box<Cargo>('cargo');
  static Box<Draft> getDraft() => Hive.box<Draft>('draft');
  static Box<Order> getOrder() => Hive.box<Order>('order');
  static Box<Cookie> getCookie() => Hive.box<Cookie>('cookie');
  static Box<Suggest> getSuggest() => Hive.box<Suggest>('suggest');
  static Box<Security> getSecurity() => Hive.box<Security>('security');
  static Box<CreateOrder> getCreateOrder() => Hive.box<CreateOrder>('create_order');
  static Box<OrdTaker> getOrdTaker() => Hive.box<OrdTaker>('ord_taker');
}
