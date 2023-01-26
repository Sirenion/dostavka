//Data file
import 'package:json_annotation/json_annotation.dart';
part 'data.g.dart';

@JsonSerializable()
class Cookie {
  String? csrftoken;
  String sessionid;

  Cookie({
    this.csrftoken,
    this.sessionid = "",
  });

  factory Cookie.fromJson(Map<String, dynamic> json) => _$CookieFromJson(json);
  Map<String, dynamic> toJson() => _$CookieToJson(this);
}

@JsonSerializable()
class Suggest {
  String url;
  String token;

  Suggest({
    this.url = "",
    this.token = "",
  });

  factory Suggest.fromJson(Map<String, dynamic> json) =>
      _$SuggestFromJson(json);
  Map<String, dynamic> toJson() => _$SuggestToJson(this);
}

@JsonSerializable()
class Auth {
  bool is_login;
  String sessionid;
  String token;
  bool sms_is_sent;
  int ct;
  int ttl;

  Auth({this.is_login = false, this.sessionid = "", this.token = "", this.sms_is_sent = false, this.ct = 1, this.ttl = 1});

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);
  Map<String, dynamic> toJson() => _$AuthToJson(this);
}

@JsonSerializable()
class Address {
  String address;

  Address({
    this.address = "",
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class User {
  String username;
  bool user_editable;
  int user_type;
  String first_name;
  String second_name;
  String last_name;
  String full_name;
  bool passport_editable;
  String passport_number;
  bool address_editable;
  List<Address>? addresses;
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

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
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

@JsonSerializable()
class Offices {
  String address;
  double geo_lon;
  double geo_lat;
  // String schedule;

  Offices({this.address = "", this.geo_lon = 0.0, this.geo_lat = 0.0});

  factory Offices.fromJson(Map<String, dynamic> json) =>
      _$OfficesFromJson(json);
  Map<String, dynamic> toJson() => _$OfficesToJson(this);
}

@JsonSerializable()
class Security {
  String username;
  String security_code;

  Security({this.username = "", this.security_code = ""});

  factory Security.fromJson(Map<String, dynamic> json) =>
      _$SecurityFromJson(json);
  Map<String, dynamic> toJson() => _$SecurityToJson(this);
}

@JsonSerializable()
class Drafts {
  int number;
  String user_from;
  String user_to;
  String date_create;
  String office_from;
  String cargo;
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

  factory Drafts.fromJson(Map<String, dynamic> json) => _$DraftsFromJson(json);
  Map<String, dynamic> toJson() => _$DraftsToJson(this);
}

@JsonSerializable()
class Draft {
  int number;
  String user_from;
  String user_to;
  String date_create;
  bool payment;
  String office_from;
  bool submit;
  List<Cargo>? cargo;
  bool by_user_to;
  bool courier_bring;
  bool returned;
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

  factory Draft.fromJson(Map<String, dynamic> json) => _$DraftFromJson(json);
  Map<String, dynamic> toJson() => _$DraftToJson(this);
}

@JsonSerializable()
class Cargo {
  String uuid;
  bool editable;
  bool need_pack;
  String name;
  double height;
  double width;
  double length;
  double weigh;
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

  factory Cargo.fromJson(Map<String, dynamic> json) => _$CargoFromJson(json);
  Map<String, dynamic> toJson() => _$CargoToJson(this);
}

@JsonSerializable()
class Promo {
  bool valid;
  String detail;

  Promo({
    this.valid = false,
    this.detail = "",
  });

  factory Promo.fromJson(Map<String, dynamic> json) => _$PromoFromJson(json);
  Map<String, dynamic> toJson() => _$PromoToJson(this);
}

@JsonSerializable()
class Orders {
  int number;
  String user_from;
  String user_to;
  String date_create;
  String office_from;
  String cargo;
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

  factory Orders.fromJson(Map<String, dynamic> json) => _$OrdersFromJson(json);
  Map<String, dynamic> toJson() => _$OrdersToJson(this);
}

@JsonSerializable()
class Order {
  int number;
  String user_from;
  String user_to;
  String date_create;
  String office_from;
  String cargo;
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

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable()
class PriceData {
  String error;
  String mod_name;
  int mod_id;
  String logo;
  String url;
  Service service;
  Cost cost;
  Discount discount;
  int time;
  bool available;

  PriceData({
    this.error = "",
    this.mod_name = "",
    this.mod_id = 1,
    this.logo = "",
    this.url = "",
    this.service = const Service(),
    this.cost = const Cost(),
    this.discount = const Discount(),
    this.time = 1,
    this.available = false,
  });

  factory PriceData.fromJson(Map<String, dynamic> json) =>
      _$PriceDataFromJson(json);
  Map<String, dynamic> toJson() => _$PriceDataToJson(this);
}

@JsonSerializable()
class Service {
  final int id;
  final String service;

  const Service({
    this.id = 1,
    this.service = "",
  });

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}

@JsonSerializable()
class Cost {
  final int cost;
  final int delivery_cost;
  final int pack_cost;
  final int office_from_keeping_cost;
  final int insurance;

  const Cost({
    this.cost = 1,
    this.delivery_cost = 1,
    this.pack_cost = 1,
    this.office_from_keeping_cost = 1,
    this.insurance = 1,
  });

  factory Cost.fromJson(Map<String, dynamic> json) => _$CostFromJson(json);
  Map<String, dynamic> toJson() => _$CostToJson(this);
}

@JsonSerializable()
class Discount {
  final String description;
  final int amount_desc;
  final int percent_desc;

  const Discount({
    this.description = "",
    this.amount_desc = 1,
    this.percent_desc = 1,
  });

  factory Discount.fromJson(Map<String, dynamic> json) =>
      _$DiscountFromJson(json);
  Map<String, dynamic> toJson() => _$DiscountToJson(this);
}

@JsonSerializable()
class Payment {
  String error;
  String p_status;
  String redirect_url;

  Payment({
    this.error = "",
    this.p_status = "",
    this.redirect_url = "",
  });

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}

@JsonSerializable()
class PVZData {
  String name;
  String code;
  String addr;
  double lat;
  double lon;

  PVZData({
    this.name = "",
    this.code = "",
    this.addr = "",
    this.lat = 0.0,
    this.lon = 0.0,
  });

  factory PVZData.fromJson(Map<String, dynamic> json) =>
      _$PVZDataFromJson(json);
  Map<String, dynamic> toJson() => _$PVZDataToJson(this);
}

@JsonSerializable()
class ResponseData {
  int code;
  dynamic meta;
  List<dynamic>? data;
  ResponseData({this.code = 0, this.meta, this.data});
  factory ResponseData.fromJson(Map<String, dynamic> json) =>
      _$ResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);
}
