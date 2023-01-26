//Data file
import 'package:hive/hive.dart';
part 'rep_data.g.dart';

@HiveType(typeId: 1)
class Cookie extends HiveObject {
  @HiveField(1, defaultValue: "")
  String csrftoken;
  @HiveField(2, defaultValue: "")
  String sessionid;
  @HiveField(3, defaultValue: "")
  String ver_code;

  Cookie({
    this.csrftoken = "",
    this.sessionid = "",
    this.ver_code = "",
  });
}

@HiveType(typeId: 2)
class Suggest extends HiveObject {
  @HiveField(1, defaultValue: "")
  String url;
  @HiveField(2, defaultValue: "")
  String token;

  Suggest({
    this.url = "",
    this.token = "",
  });
}

@HiveType(typeId: 3)
class Auth extends HiveObject {
  @HiveField(1, defaultValue: false)
  bool is_login;
  @HiveField(2, defaultValue: "")
  String sessionid;
  @HiveField(3, defaultValue: "")
  String token;

  Auth({this.is_login = false, this.sessionid = "", this.token = ""});
}

@HiveType(typeId: 4)
class Address extends HiveObject {
  @HiveField(1, defaultValue: "")
  String address;

  Address({
    this.address = "",
  });
}

@HiveType(typeId: 5)
class User extends HiveObject {
  @HiveField(1, defaultValue: "")
  String username;
  @HiveField(2, defaultValue: false)
  bool user_editable;
  @HiveField(3, defaultValue: 1)
  int user_type;
  @HiveField(4, defaultValue: "")
  String first_name;
  @HiveField(5, defaultValue: "")
  String second_name;
  @HiveField(6, defaultValue: "")
  String last_name;
  @HiveField(7, defaultValue: "")
  String full_name;
  @HiveField(8, defaultValue: false)
  bool passport_editable;
  @HiveField(9, defaultValue: "")
  String passport_number;
  @HiveField(10, defaultValue: false)
  bool address_editable;
  // @HiveField(11, defaultValue: "")
  // Address address; //rework
  @HiveField(11, defaultValue: "")
  String token;
  @HiveField(12, defaultValue: false)
  bool isRegistered;
  @HiveField(13, defaultValue: false)
  bool biometric;
  @HiveField(14, defaultValue: false)
  bool sender_password;
  @HiveField(15, defaultValue: "")
  String csrftoken;
  @HiveField(16, defaultValue: "")
  String sessionid;
  @HiveField(17, defaultValue: false)
  bool is_login;
  @HiveField(18, defaultValue: "")
  String address;
  @HiveField(19, defaultValue: 0.0)
  double lat;
  @HiveField(20, defaultValue: 0.0)
  double lon;

  User({
    this.username = "",
    this.user_editable = false,
    this.user_type = 1,
    this.first_name = "",
    this.second_name = "",
    this.last_name = "",
    this.full_name = "",
    this.passport_editable = false,
    this.passport_number = "",
    this.address_editable = false,
    // this.address = Address(),
    this.token = "",
    this.isRegistered = false,
    this.biometric = false,
    this.sender_password = false,
    this.csrftoken = "",
    this.sessionid = "",
    this.is_login = false,
    this.address = "",
    this.lat = 0.0,
    this.lon = 0.0
  });

  @override
  String toString() {
    return 'User{'
        'username: $username, '
        'user_editable: $user_editable, '
        'user_type: $user_type, '
        'first_name: $first_name, '
        'second_name: $second_name, '
        'last_name: $last_name, '
        'full_name: $full_name, '
        'passport_editable: $passport_editable, '
        'passport_number: $passport_number, '
        'address_editable: $address_editable, '
        'token: $token, '
        'isRegistered: $isRegistered, '
        'biometric: $biometric, '
        'sender_password: $sender_password, '
        'csrftoken: $csrftoken, '
        'sessionid: $sessionid, '
        'is_login: $is_login, '
        'address: $address}';
  }
}

@HiveType(typeId: 7)
class Security extends HiveObject {
  @HiveField(1, defaultValue: "")
  String username;
  @HiveField(2, defaultValue: "")
  String security_code;

  Security({this.username = "", this.security_code = ""});
}

@HiveType(typeId: 9)
class Draft extends HiveObject {
  @HiveField(1, defaultValue: 1)
  int number;
  @HiveField(2, defaultValue: "")
  String user_from;
  @HiveField(3, defaultValue: "")
  String user_to;
  @HiveField(4, defaultValue: "")
  String date_create;
  @HiveField(5, defaultValue: false)
  bool payment;
  @HiveField(6, defaultValue: "")
  String office_from;
  @HiveField(7, defaultValue: false)
  bool submit;
  //   @HiveField(1, defaultValue: "")
  List<Cargo>? cargo;
  @HiveField(8, defaultValue: false)
  bool by_user_to;
  @HiveField(9, defaultValue: false)
  bool courier_bring;
  @HiveField(10, defaultValue: false)
  bool returned;
  @HiveField(11, defaultValue: "")
  String free_keep;
  @HiveField(12, defaultValue: {})
  Map<String, dynamic> delivery;

  Draft({
    this.number = 1,
    this.user_from = "",
    this.user_to = "",
    this.date_create = "",
    this.payment = false,
    this.office_from = "",
    this.submit = false,
    this.cargo,
    this.by_user_to = false,
    this.courier_bring = false,
    this.returned = false,
    this.free_keep = "",
    this.delivery = const {},
  });

  @override
  String toString() {
    return 'Draft{number: $number, user_from: $user_from, user_to: $user_to, date_create: $date_create, payment: $payment, office_from: $office_from, submit: $submit, cargo: $cargo, by_user_to: $by_user_to, courier_bring: $courier_bring, returned: $returned, free_keep: $free_keep, delivery: $delivery}';
  }
}

@HiveType(typeId: 10)
class Cargo extends HiveObject {
  @HiveField(1, defaultValue: "")
  String uuid;
  @HiveField(2, defaultValue: false)
  bool editable;
  @HiveField(3, defaultValue: false)
  bool need_pack;
  @HiveField(4, defaultValue: "")
  String name;
  @HiveField(5, defaultValue: 0.0)
  double height;
  @HiveField(6, defaultValue: 0.0)
  double width;
  @HiveField(7, defaultValue: 0.0)
  double length;
  @HiveField(8, defaultValue: 0.0)
  double weigh;
  @HiveField(9, defaultValue: 0.0)
  double declared_value;
  List<String>? photos;
//
  Cargo({
    this.uuid = "",
    this.editable = false,
    this.need_pack = false,
    this.name = "",
    this.height = 0.0,
    this.width = 0.0,
    this.length = 0.0,
    this.weigh = 0.0,
    this.declared_value = 0.0,
    this.photos,
  });
}

@HiveType(typeId: 13)
class Order extends HiveObject {
  @HiveField(1, defaultValue: 1)
  int number;
  @HiveField(2, defaultValue: "")
  String user_from;
  @HiveField(3, defaultValue: "")
  String user_to;
  @HiveField(4, defaultValue: "")
  String date_create;
  @HiveField(5, defaultValue: "")
  String office_from;
  @HiveField(6, defaultValue: "")
  String cargo;
  @HiveField(7, defaultValue: "")
  String status;

  Order({
    this.number = 1,
    this.user_from = "",
    this.user_to = "",
    this.date_create = "",
    this.office_from = "",
    this.cargo = "",
    this.status = "",
  });
}

@HiveType(typeId: 14)
class CreateOrder extends HiveObject {
  @HiveField(1, defaultValue: {})
  Map<String, dynamic> from;
  @HiveField(2, defaultValue: {})
  Map<String, dynamic> to;
  @HiveField(3, defaultValue: false)
  bool courierBring;

  CreateOrder({
    this.from = const {},
    this.to = const {},
    this.courierBring = false,
  });
}

@HiveType(typeId: 15)
class OrdTaker extends HiveObject {
  @HiveField(1, defaultValue: "")
  String username;
  @HiveField(2, defaultValue: false)
  bool user_editable;
  @HiveField(3, defaultValue: 1)
  int user_type;
  @HiveField(4, defaultValue: "")
  String first_name;
  @HiveField(5, defaultValue: "")
  String second_name;
  @HiveField(6, defaultValue: "")
  String last_name;
  @HiveField(7, defaultValue: "")
  String full_name;
  @HiveField(8, defaultValue: false)
  bool passport_editable;
  @HiveField(9, defaultValue: "")
  String passport_number;
  @HiveField(10, defaultValue: false)
  bool address_editable;

  // @HiveField(11, defaultValue: "")
  // Address address; //rework
  @HiveField(11, defaultValue: "")
  String token;
  @HiveField(12, defaultValue: false)
  bool isRegistered;
  @HiveField(13, defaultValue: false)
  bool biometric;
  @HiveField(14, defaultValue: false)
  bool sender_password;
  @HiveField(15, defaultValue: "")
  String csrftoken;
  @HiveField(16, defaultValue: "")
  String sessionid;
  @HiveField(17, defaultValue: false)
  bool is_login;
  @HiveField(18, defaultValue: "")
  String address;
  @HiveField(19, defaultValue: 0.0)
  double lat;
  @HiveField(20, defaultValue: 0.0)
  double lon;

  OrdTaker({
    this.username = "",
    this.user_editable = false,
    this.user_type = 1,
    this.first_name = "",
    this.second_name = "",
    this.last_name = "",
    this.full_name = "",
    this.passport_editable = false,
    this.passport_number = "",
    this.address_editable = false,
    // this.address = Address(),
    this.token = "",
    this.isRegistered = false,
    this.biometric = false,
    this.sender_password = false,
    this.csrftoken = "",
    this.sessionid = "",
    this.is_login = false,
    this.address = "",
    this.lat = 0.0,
    this.lon = 0.0
  });
}

