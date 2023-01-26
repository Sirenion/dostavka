import 'package:dostavka/models/hive_connection/boxes.dart';
import 'package:dostavka/models/hive_connection/rep_data.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

//
class Update {
  static void fullEditUser(User user, {
    String? username,
    bool? user_editable,
    int? user_type,
    String? first_name,
    String? second_name,
    String? last_name,
    String? full_name,
    bool? passport_editable,
    String? passport_number,
    bool? address_editable,
    String? token,
    bool? isRegistered,
    bool? biometric,
    bool? sender_password,
    String? csrftoken,
    String? sessionid,
    bool? is_login,
    String? address,
  }) {
    username != null ? user.username = username : user.username;
    user_editable != null
        ? user.user_editable = user_editable
        : user.user_editable;
    user_type != null ? user.user_type = user_type : user.user_type;
    first_name != null ? user.first_name = first_name : user.first_name;
    second_name != null ? user.second_name = second_name : user.second_name;
    last_name != null ? user.last_name = last_name : user.last_name;
    full_name != null ? user.full_name = full_name : user.full_name;
    passport_editable != null
        ? user.passport_editable = passport_editable
        : user.passport_editable;
    passport_number != null
        ? user.passport_number = passport_number
        : user.passport_number;
    address_editable != null
        ? user.address_editable = address_editable
        : user.address_editable;
    token != null ? user.token = token : user.token;
    isRegistered != null ? user.isRegistered = isRegistered : user.isRegistered;
    biometric != null ? user.biometric = biometric : user.biometric;
    sender_password != null
        ? user.sender_password = sender_password
        : user.sender_password;
    csrftoken != null ? user.csrftoken = csrftoken : user.csrftoken;
    sessionid != null ? user.sessionid = sessionid : user.sessionid;
    is_login != null ? user.is_login = is_login : user.is_login;
    address != null ? user.address = address : user.address;

    user.save();
  }

  static void EditUser(User user, {
    String? username,
    bool? user_editable,
    int? user_type,
    String? first_name,
    String? second_name,
    String? last_name,
    String? full_name,
    bool? passport_editable,
    String? passport_number,
    bool? address_editable,
    String? token,
    bool? isRegistered,
    bool? biometric,
    bool? sender_password,
    String? csrftoken,
    String? sessionid,
    bool? is_login,
    String? address,
    double lat = 0.0,
    double lon = 0.0
  }) {
    username != null ? user.username = username : user.username;
    user_editable != null
        ? user.user_editable = user_editable
        : user.user_editable;
    user_type != null ? user.user_type = user_type : user.user_type;
    first_name != null ? user.first_name = first_name : user.first_name;
    second_name != null ? user.second_name = second_name : user.second_name;
    last_name != null ? user.last_name = last_name : user.last_name;
    full_name != null ? user.full_name = full_name : user.full_name;
    passport_editable != null
        ? user.passport_editable = passport_editable
        : user.passport_editable;
    passport_number != null
        ? user.passport_number = passport_number
        : user.passport_number;
    address_editable != null
        ? user.address_editable = address_editable
        : user.address_editable;
    token != null ? user.token = token : user.token;
    isRegistered != null ? user.isRegistered = isRegistered : user.isRegistered;
    biometric != null ? user.biometric = biometric : user.biometric;
    sender_password != null
        ? user.sender_password = sender_password
        : user.sender_password;
    csrftoken != null ? user.csrftoken = csrftoken : user.csrftoken;
    sessionid != null ? user.sessionid = sessionid : user.sessionid;
    is_login != null ? user.is_login = is_login : user.is_login;
    address != null ? user.address = address : user.address;
    user.lat = lat;
    user.lon = lon;
    print('USER UPDATE PRINT ==================== ${user.toString()}');
    user.save();
  }

  static void editSecurityCode(Security security, String security_code) {
    security.security_code = security_code;

    security.save();
  }

  static void editSuggest(Suggest suggest, String url, String token) {
    suggest.url = url;
    suggest.token = token;
    suggest.save();
  }

  static void editDraft(Draft draft, {
    int? number,
    String? user_from,
    String? user_to,
    String? date_create,
    bool? payment,
    String? office_from,
    bool? submit,
    bool? by_user_to,
    bool? courier_bring,
    bool? returned,
    String? free_keep,
    Map<String, dynamic>? delivery,
  }) {
    number != null ? draft.number = number : draft.number;
    user_from != null ? draft.user_from = user_from : draft.user_from;
    user_to != null ? draft.user_to = user_to : draft.user_to;
    date_create != null ? draft.date_create = date_create : draft.date_create;
    payment != null ? draft.payment = payment : draft.payment;
    office_from != null ? draft.office_from = office_from : draft.office_from;
    submit != null ? draft.submit = submit : draft.submit;
    by_user_to != null ? draft.by_user_to = by_user_to : draft.by_user_to;
    courier_bring != null
        ? draft.courier_bring = courier_bring
        : draft.courier_bring;
    returned != null ? draft.returned = returned : draft.returned;
    free_keep != null ? draft.free_keep = free_keep : draft.free_keep;
    delivery != null ? draft.delivery = delivery : draft.delivery;

    draft.save();
  }

  static void editCargo(Cargo cargo, {
    String? uuid,
    bool? editable,
    bool? need_pack,
    String? name,
    double? height,
    double? width,
    double? length,
    double? weigh,
    double? declared_value,
  }) {
    uuid != null ? cargo.uuid = uuid : cargo.uuid;
    editable != null ? cargo.editable = editable : cargo.editable;
    need_pack != null ? cargo.need_pack = need_pack : cargo.need_pack;
    name != null ? cargo.name = name : cargo.name;
    height != null ? cargo.height = height : cargo.height;
    width != null ? cargo.width = width : cargo.width;
    length != null ? cargo.length = length : cargo.length;
    weigh != null ? cargo.weigh = weigh : cargo.weigh;
    declared_value != null
        ? cargo.declared_value = declared_value
        : cargo.declared_value;

    cargo.save();
  }

  static void editCreateOrder(CreateOrder createOrder, {
    Map<String, dynamic>? from,
    Map<String, dynamic>? to,
    bool? courierBring,
  }) {
    from != null ? createOrder.from = from : createOrder.from;
    to != null ? createOrder.to = to : createOrder.to;
    courierBring != null ? createOrder.courierBring = courierBring : createOrder.courierBring;

    createOrder.save();
  }

  static void EditOrdTaker(OrdTaker user, {
    String? username,
    bool? user_editable,
    int? user_type,
    String? first_name,
    String? second_name,
    String? last_name,
    String? full_name,
    bool? passport_editable,
    String? passport_number,
    bool? address_editable,
    String? token,
    bool? isRegistered,
    bool? biometric,
    bool? sender_password,
    String? csrftoken,
    String? sessionid,
    bool? is_login,
    String? address,
    double lat = 0.0,
    double lon = 0.0
  }) {
    username != null ? user.username = username : user.username;
    user_editable != null
        ? user.user_editable = user_editable
        : user.user_editable;
    user_type != null ? user.user_type = user_type : user.user_type;
    first_name != null ? user.first_name = first_name : user.first_name;
    second_name != null ? user.second_name = second_name : user.second_name;
    last_name != null ? user.last_name = last_name : user.last_name;
    full_name != null ? user.full_name = full_name : user.full_name;
    passport_editable != null
        ? user.passport_editable = passport_editable
        : user.passport_editable;
    passport_number != null
        ? user.passport_number = passport_number
        : user.passport_number;
    address_editable != null
        ? user.address_editable = address_editable
        : user.address_editable;
    token != null ? user.token = token : user.token;
    isRegistered != null ? user.isRegistered = isRegistered : user.isRegistered;
    biometric != null ? user.biometric = biometric : user.biometric;
    sender_password != null
        ? user.sender_password = sender_password
        : user.sender_password;
    csrftoken != null ? user.csrftoken = csrftoken : user.csrftoken;
    sessionid != null ? user.sessionid = sessionid : user.sessionid;
    is_login != null ? user.is_login = is_login : user.is_login;
    address != null ? user.address = address : user.address;
    user.lat = lat;
    user.lon = lon;
    print('USER UPDATE PRINT ==================== ${user.toString()}');
    user.save();
  }
}



// static void EditUser(
//   User user, {
//   String username = "-",
//   bool user_editable = false,
//   int user_type = 1,
//   String first_name = "-",
//   String second_name = "-",
//   String last_name = "-",
//   String full_name = "-",
//   bool passport_editable = false,
//   String passport_number = "-",
//   bool address_editable = false,
//   String token = "-",
//   bool isRegistered = false,
//   bool biometric = false,
//   bool sender_password = false,
//   String csrftoken = "-",
//   String sessionid = "-",
//   bool is_login = false,
//   String address = "-",
// }) {
//   if (user.username == "" || (username != "-" && user.username != username)) {
//     user.username = username;
//   }
//   if (user.first_name == "" ||
//       (first_name != "-" && user.first_name != first_name)) {
//     user.first_name = first_name;
//   }
//   if (user.second_name == "" ||
//       (second_name != "-" && user.second_name != second_name)) {
//     user.second_name = second_name;
//   }
//   if (user.last_name == "" ||
//       (last_name != "-" && user.last_name != last_name)) {
//     user.last_name = last_name;
//   }
//   if (user.full_name == "" ||
//       (full_name != "-" && user.full_name != full_name)) {
//     user.full_name = full_name;
//   }
//   if (user.passport_number == "" ||
//       (passport_number != "-" && user.passport_number != passport_number)) {
//     user.passport_number = passport_number;
//   }
//   if (user.token == "" || (token != "-" && user.token != token)) {
//     user.token = token;
//   }
//   user.biometric = biometric;
//   user.sender_password = sender_password;
//   if (user.csrftoken == "" ||
//       (csrftoken != "-" && user.csrftoken != csrftoken)) {
//     user.csrftoken = csrftoken;
//   }
//   if (user.sessionid == "" ||
//       (sessionid != "-" && user.sessionid != sessionid)) {
//     user.sessionid = sessionid;
//   }
//   print('user update print ------- user login before ${user.is_login}');
//   if(user.is_login != is_login){
//     user.is_login = is_login;
//   }
//   print('user update print ------- user login after ${user.is_login}');
//   if (user.address == "" || (address != "-" && user.address != address)) {
//     user.address = address;
//   }
//   // final box = Boxes.getTransactions();
//   // box.put(transaction.key, transaction);
//   print('USER UPDATE PRINT ==================== ${user.toString()}');
//   user.save();
// }
