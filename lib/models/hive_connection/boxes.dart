import 'package:hive/hive.dart';
import 'package:dostavka/models/hive_connection/rep_data.dart';

// await Hive.openBox<User>('user');
// await Hive.openBox<Address>('address');
// await Hive.openBox<Auth>('auth');
// await Hive.openBox<Cargo>('cargo');
// await Hive.openBox<Draft>('draft');
// await Hive.openBox<Order>('order');
// await Hive.openBox<Promo>('promo');
// await Hive.openBox<Cookie>('cookie');
// await Hive.openBox<Drafts>('drafts');
// await Hive.openBox<Orders>('orders');
// await Hive.openBox<Offices>('offices');
// await Hive.openBox<Suggest>('suggest');
// await Hive.openBox<Security>('security');
//
class Boxes {
  static Box<User> getUser() => Hive.box<User>('user');
  static Box<Address> getAddress() => Hive.box<Address>('address');
  static Box<Auth> getAuth() => Hive.box<Auth>('auth');
  static Box<Cargo> getCargo() => Hive.box<Cargo>('cargo');
  static Box<Draft> getDraft() => Hive.box<Draft>('draft');
  static Box<Order> getOrder() => Hive.box<Order>('order');
  static Box<Cookie> getCookie() => Hive.box<Cookie>('cookie');
  static Box<Suggest> getSuggest() => Hive.box<Suggest>('suggest');
  static Box<Security> getSecurity() => Hive.box<Security>('security');
}
