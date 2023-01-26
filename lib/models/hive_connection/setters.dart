import 'package:dostavka/models/hive_connection/boxes.dart';
import 'package:dostavka/models/hive_connection/getters.dart';
import 'package:dostavka/models/hive_connection/rep_data.dart';
import 'package:hive/hive.dart';

//
class Setters {
  static addUser() async {
    final user = User();

    final box = Boxes.getUser();
    box.add(user);
  }

  static addAuth() async {
    final auth = Auth();

    final box = Boxes.getAuth();
    box.add(auth);
  }

  static addAddress() async {
    final address = Address();

    final box = Boxes.getAddress();
    box.add(address);
  }

  static addCargo() async {
    final cargo = Cargo();

    final box = Boxes.getCargo();
    box.add(cargo);
  }

  static addDraft() async {
    final draft = Draft();

    final box = Boxes.getDraft();
    box.add(draft);
  }

  static addOrder() async {
    final order = Order();

    final box = Boxes.getOrder();
    box.add(order);
  }

  static addCookie() async {
    final cookie = Cookie();

    final box = Boxes.getCookie();
    box.add(cookie);
  }

  static addSuggest() async {
    final suggest = Suggest();

    final box = Boxes.getSuggest();
    box.add(suggest);
  }

  static addSecurity() async {
    final security = Security();

    final box = Boxes.getSecurity();
    box.add(security);
  }

  static addCreateOrder() async{
    final createOrder = CreateOrder();

    final box = Getters.getCreateOrder();
    box.add(createOrder);
  }

  static addOrdTaker() async{
    final ordTaker = OrdTaker();

    final box = Getters.getOrdTaker();
    box.add(ordTaker);
  }

  //TODO ПАША ПОПРАВЬ КАКУЮ ТО ХУЙНЮ, МЫ ОБОСРАЛИСЬ
}
