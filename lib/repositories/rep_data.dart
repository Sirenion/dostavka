//Data file
import 'package:hive/hive.dart';
part 'rep_data.g.dart';

@HiveType(typeId: 1)
class Cookie {
  @HiveField(1, defaultValue: "")
  String csrftoken;
  @HiveField(2, defaultValue: "")
  String sessionid;

  Cookie({
    this.csrftoken = "",
    this.sessionid = "",
  });
}

@HiveType(typeId: 2)
class Suggest {
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
class Auth {
  @HiveField(1, defaultValue: false)
  bool is_login;
  @HiveField(2, defaultValue: "")
  String sessionid;
  @HiveField(3, defaultValue: "")
  String token;

  Auth({this.is_login = false, this.sessionid = "", this.token = ""});
}

@HiveType(typeId: 4)
class Address {
  @HiveField(1, defaultValue: "")
  final String address;

  const Address({
    this.address = "",
  });
}

@HiveType(typeId: 5)
class User {
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
  List<Address>? addresses; //rework
  @HiveField(11, defaultValue: "")
  String token;

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
    this.addresses,
    this.token = "",
  });
}

// @JsonSerializable()
// class Passport {
//   String name;
//   String secName;
//   String famName;
//   String phone;
//   String token;

//   Passport(
//       {this.name,
//       this.email,
//       this.gender,
//       this.status,
//       this.created_at,
//       this.updated_at});

//   factory Passport.fromJson(Map<String, dynamic> json) =>
//       _$PassportFromJson(json);
//   Map<String, dynamic> toJson() => _$PassportToJson(this);
// }

@HiveType(typeId: 6)
class Offices {
  @HiveField(1, defaultValue: "")
  String address;
  @HiveField(2, defaultValue: 0.0)
  double geo_lon;
  @HiveField(3, defaultValue: 0.0)
  double geo_lat;
  // String schedule;
  Offices({this.address = "", this.geo_lon = 0.0, this.geo_lat = 0.0});
}

@HiveType(typeId: 7)
class Security {
  @HiveField(1, defaultValue: "")
  String username;
  @HiveField(2, defaultValue: "")
  String security_code;

  Security({this.username = "", this.security_code = ""});
}

@HiveType(typeId: 8)
class Drafts {
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

  Drafts({
    this.number = 1,
    this.user_from = "",
    this.user_to = "",
    this.date_create = "",
    this.office_from = "",
    this.cargo = "",
    this.status = "",
  });
}

@HiveType(typeId: 9)
class Draft {
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
  });
}

@HiveType(typeId: 10)
class Cargo {
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

@HiveType(typeId: 11)
class Promo {
  @HiveField(1, defaultValue: false)
  bool valid;
  @HiveField(2, defaultValue: "")
  String detail;

  Promo({
    this.valid = false,
    this.detail = "",
  });
}

@HiveType(typeId: 12)
class Orders {
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

  Orders({
    this.number = 1,
    this.user_from = "",
    this.user_to = "",
    this.date_create = "",
    this.office_from = "",
    this.cargo = "",
    this.status = "",
  });
}

@HiveType(typeId: 13)
class Order {
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

// @HiveType(typeId: 14)
// class PriceData {
//   @HiveField(1, defaultValue: "")
//   String error;
//   @HiveField(2, defaultValue: "")
//   String mod_name;
//   @HiveField(3, defaultValue: 1)
//   int mod_id;
//   @HiveField(4, defaultValue: "")
//   String logo;
//   @HiveField(5, defaultValue: "")
//   String url;
//   @HiveField(6, defaultValue: "")
//   Service service;
//   @HiveField(7, defaultValue: "")
//   Cost cost;
//   @HiveField(8, defaultValue: "")
//   Discount discount;
//   @HiveField(9, defaultValue: "")
//   int time;
//   @HiveField(10, defaultValue: "")
//   bool available;
// }

// @HiveType(typeId: 1)
// class Service {
//   final int id;
//   final String service;

//   const Service({
//     this.id = 1,
//     this.service = "",
//   });

//   factory Service.fromJson(Map<String, dynamic> json) =>
//       _$ServiceFromJson(json);
//   Map<String, dynamic> toJson() => _$ServiceToJson(this);
// }

// @HiveType(typeId: 1)
// class Cost {
//   final int cost;
//   final int delivery_cost;
//   final int pack_cost;
//   final int office_from_keeping_cost;
//   final int insurance;

//   const Cost({
//     this.cost = 1,
//     this.delivery_cost = 1,
//     this.pack_cost = 1,
//     this.office_from_keeping_cost = 1,
//     this.insurance = 1,
//   });

//   factory Cost.fromJson(Map<String, dynamic> json) => _$CostFromJson(json);
//   Map<String, dynamic> toJson() => _$CostToJson(this);
// }

// @HiveType(typeId: 1)
// class Discount {
//   final String description;
//   final int amount_desc;
//   final int percent_desc;

//   const Discount({
//     this.description = "",
//     this.amount_desc = 1,
//     this.percent_desc = 1,
//   });

//   factory Discount.fromJson(Map<String, dynamic> json) =>
//       _$DiscountFromJson(json);
//   Map<String, dynamic> toJson() => _$DiscountToJson(this);
// }

// @HiveType(typeId: 1)
// class Payment {
//   String error;
//   String p_status;
//   String redirect_url;

//   Payment({
//     this.error = "",
//     this.p_status = "",
//     this.redirect_url = "",
//   });

//   factory Payment.fromJson(Map<String, dynamic> json) =>
//       _$PaymentFromJson(json);
//   Map<String, dynamic> toJson() => _$PaymentToJson(this);
// }

// @HiveType(typeId: 1)
// class PVZData {
//   String name;
//   String code;
//   String addr;
//   double lat;
//   double lon;

//   PVZData({
//     this.name = "",
//     this.code = "",
//     this.addr = "",
//     this.lat = 0.0,
//     this.lon = 0.0,
//   });

//   factory PVZData.fromJson(Map<String, dynamic> json) =>
//       _$PVZDataFromJson(json);
//   Map<String, dynamic> toJson() => _$PVZDataToJson(this);
// }

// @HiveType(typeId: 1)
// class ResponseData {
//   int code;
//   dynamic meta;
//   List<dynamic>? data;
//   ResponseData({this.code = 0, this.meta, this.data});
//   factory ResponseData.fromJson(Map<String, dynamic> json) =>
//       _$ResponseDataFromJson(json);
//   Map<String, dynamic> toJson() => _$ResponseDataToJson(this);
// }
