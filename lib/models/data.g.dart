// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cookie _$CookieFromJson(Map<String, dynamic> json) => Cookie(
      csrftoken: json['csrftoken'] as String?,
      sessionid: json['sessionid'] as String? ?? "",
    );

Map<String, dynamic> _$CookieToJson(Cookie instance) => <String, dynamic>{
      'csrftoken': instance.csrftoken,
      'sessionid': instance.sessionid,
    };

Suggest _$SuggestFromJson(Map<String, dynamic> json) => Suggest(
      url: json['url'] as String? ?? "",
      token: json['token'] as String? ?? "",
    );

Map<String, dynamic> _$SuggestToJson(Suggest instance) => <String, dynamic>{
      'url': instance.url,
      'token': instance.token,
    };

Auth _$AuthFromJson(Map<String, dynamic> json) => Auth(
      is_login: json['is_login'] as bool? ?? false,
      sessionid: json['sessionid'] as String? ?? "",
      token: json['token'] as String? ?? "",
      sms_is_sent: json['sms_is_sent'] as bool? ?? false,
      ct: json['ct'] as int? ?? 1,
      ttl: json['ttl'] as int? ?? 1,
    );

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{
      'is_login': instance.is_login,
      'sessionid': instance.sessionid,
      'token': instance.token,
      'sms_is_sent': instance.sms_is_sent,
      'ct': instance.ct,
      'ttl': instance.ttl,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      address: json['address'] as String? ?? "",
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'address': instance.address,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      username: json['username'] as String? ?? "",
      user_editable: json['user_editable'] as bool? ?? false,
      user_type: json['user_type'] as int? ?? 1,
      first_name: json['first_name'] as String? ?? "",
      second_name: json['second_name'] as String? ?? "",
      last_name: json['last_name'] as String? ?? "",
      full_name: json['full_name'] as String? ?? "",
      passport_editable: json['passport_editable'] as bool? ?? false,
      passport_number: json['passport_number'] as String? ?? "",
      address_editable: json['address_editable'] as bool? ?? false,
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
      token: json['token'] as String? ?? "",
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'user_editable': instance.user_editable,
      'user_type': instance.user_type,
      'first_name': instance.first_name,
      'second_name': instance.second_name,
      'last_name': instance.last_name,
      'full_name': instance.full_name,
      'passport_editable': instance.passport_editable,
      'passport_number': instance.passport_number,
      'address_editable': instance.address_editable,
      'addresses': instance.addresses,
      'token': instance.token,
    };

Offices _$OfficesFromJson(Map<String, dynamic> json) => Offices(
      address: json['address'] as String? ?? "",
      geo_lon: (json['geo_lon'] as num?)?.toDouble() ?? 0.0,
      geo_lat: (json['geo_lat'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$OfficesToJson(Offices instance) => <String, dynamic>{
      'address': instance.address,
      'geo_lon': instance.geo_lon,
      'geo_lat': instance.geo_lat,
    };

Security _$SecurityFromJson(Map<String, dynamic> json) => Security(
      username: json['username'] as String? ?? "",
      security_code: json['security_code'] as String? ?? "",
    );

Map<String, dynamic> _$SecurityToJson(Security instance) => <String, dynamic>{
      'username': instance.username,
      'security_code': instance.security_code,
    };

Drafts _$DraftsFromJson(Map<String, dynamic> json) => Drafts(
      number: json['number'] as int? ?? 1,
      user_from: json['user_from'] as String? ?? "",
      user_to: json['user_to'] as String? ?? "",
      date_create: json['date_create'] as String? ?? "",
      office_from: json['office_from'] as String? ?? "",
      cargo: json['cargo'] as String? ?? "",
      status: json['status'] as String? ?? "",
    );

Map<String, dynamic> _$DraftsToJson(Drafts instance) => <String, dynamic>{
      'number': instance.number,
      'user_from': instance.user_from,
      'user_to': instance.user_to,
      'date_create': instance.date_create,
      'office_from': instance.office_from,
      'cargo': instance.cargo,
      'status': instance.status,
    };

Draft _$DraftFromJson(Map<String, dynamic> json) => Draft(
      number: json['number'] as int? ?? 1,
      user_from: json['user_from'] as String? ?? "",
      user_to: json['user_to'] as String? ?? "",
      date_create: json['date_create'] as String? ?? "",
      payment: json['payment'] as bool? ?? false,
      office_from: json['office_from'] as String? ?? "",
      submit: json['submit'] as bool? ?? false,
      cargo: (json['cargo'] as List<dynamic>?)
          ?.map((e) => Cargo.fromJson(e as Map<String, dynamic>))
          .toList(),
      by_user_to: json['by_user_to'] as bool? ?? false,
      courier_bring: json['courier_bring'] as bool? ?? false,
      returned: json['returned'] as bool? ?? false,
      free_keep: json['free_keep'] as String? ?? "",
    );

Map<String, dynamic> _$DraftToJson(Draft instance) => <String, dynamic>{
      'number': instance.number,
      'user_from': instance.user_from,
      'user_to': instance.user_to,
      'date_create': instance.date_create,
      'payment': instance.payment,
      'office_from': instance.office_from,
      'submit': instance.submit,
      'cargo': instance.cargo,
      'by_user_to': instance.by_user_to,
      'courier_bring': instance.courier_bring,
      'returned': instance.returned,
      'free_keep': instance.free_keep,
    };

Cargo _$CargoFromJson(Map<String, dynamic> json) => Cargo(
      uuid: json['uuid'] as String? ?? "",
      editable: json['editable'] as bool? ?? false,
      need_pack: json['need_pack'] as bool? ?? false,
      name: json['name'] as String? ?? "",
      height: (json['height'] as num?)?.toDouble() ?? 0.0,
      width: (json['width'] as num?)?.toDouble() ?? 0.0,
      length: (json['length'] as num?)?.toDouble() ?? 0.0,
      weigh: (json['weigh'] as num?)?.toDouble() ?? 0.0,
      declared_value: (json['declared_value'] as num?)?.toDouble() ?? 0.0,
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CargoToJson(Cargo instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'editable': instance.editable,
      'need_pack': instance.need_pack,
      'name': instance.name,
      'height': instance.height,
      'width': instance.width,
      'length': instance.length,
      'weigh': instance.weigh,
      'declared_value': instance.declared_value,
      'photos': instance.photos,
    };

Promo _$PromoFromJson(Map<String, dynamic> json) => Promo(
      valid: json['valid'] as bool? ?? false,
      detail: json['detail'] as String? ?? "",
    );

Map<String, dynamic> _$PromoToJson(Promo instance) => <String, dynamic>{
      'valid': instance.valid,
      'detail': instance.detail,
    };

Orders _$OrdersFromJson(Map<String, dynamic> json) => Orders(
      number: json['number'] as int? ?? 1,
      user_from: json['user_from'] as String? ?? "",
      user_to: json['user_to'] as String? ?? "",
      date_create: json['date_create'] as String? ?? "",
      office_from: json['office_from'] as String? ?? "",
      cargo: json['cargo'] as String? ?? "",
      status: json['status'] as String? ?? "",
    );

Map<String, dynamic> _$OrdersToJson(Orders instance) => <String, dynamic>{
      'number': instance.number,
      'user_from': instance.user_from,
      'user_to': instance.user_to,
      'date_create': instance.date_create,
      'office_from': instance.office_from,
      'cargo': instance.cargo,
      'status': instance.status,
    };

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      number: json['number'] as int? ?? 1,
      user_from: json['user_from'] as String? ?? "",
      user_to: json['user_to'] as String? ?? "",
      date_create: json['date_create'] as String? ?? "",
      office_from: json['office_from'] as String? ?? "",
      cargo: json['cargo'] as String? ?? "",
      status: json['status'] as String? ?? "",
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'number': instance.number,
      'user_from': instance.user_from,
      'user_to': instance.user_to,
      'date_create': instance.date_create,
      'office_from': instance.office_from,
      'cargo': instance.cargo,
      'status': instance.status,
    };

PriceData _$PriceDataFromJson(Map<String, dynamic> json) => PriceData(
      error: json['error'] as String? ?? "",
      mod_name: json['mod_name'] as String? ?? "",
      mod_id: json['mod_id'] as int? ?? 1,
      logo: json['logo'] as String? ?? "",
      url: json['url'] as String? ?? "",
      service: json['service'] == null
          ? const Service()
          : Service.fromJson(json['service'] as Map<String, dynamic>),
      cost: json['cost'] == null
          ? const Cost()
          : Cost.fromJson(json['cost'] as Map<String, dynamic>),
      discount: json['discount'] == null
          ? const Discount()
          : Discount.fromJson(json['discount'] as Map<String, dynamic>),
      time: json['time'] as int? ?? 1,
      available: json['available'] as bool? ?? false,
    );

Map<String, dynamic> _$PriceDataToJson(PriceData instance) => <String, dynamic>{
      'error': instance.error,
      'mod_name': instance.mod_name,
      'mod_id': instance.mod_id,
      'logo': instance.logo,
      'url': instance.url,
      'service': instance.service,
      'cost': instance.cost,
      'discount': instance.discount,
      'time': instance.time,
      'available': instance.available,
    };

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
      id: json['id'] as int? ?? 1,
      service: json['service'] as String? ?? "",
    );

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'id': instance.id,
      'service': instance.service,
    };

Cost _$CostFromJson(Map<String, dynamic> json) => Cost(
      cost: json['cost'] as int? ?? 1,
      delivery_cost: json['delivery_cost'] as int? ?? 1,
      pack_cost: json['pack_cost'] as int? ?? 1,
      office_from_keeping_cost: json['office_from_keeping_cost'] as int? ?? 1,
      insurance: json['insurance'] as int? ?? 1,
    );

Map<String, dynamic> _$CostToJson(Cost instance) => <String, dynamic>{
      'cost': instance.cost,
      'delivery_cost': instance.delivery_cost,
      'pack_cost': instance.pack_cost,
      'office_from_keeping_cost': instance.office_from_keeping_cost,
      'insurance': instance.insurance,
    };

Discount _$DiscountFromJson(Map<String, dynamic> json) => Discount(
      description: json['description'] as String? ?? "",
      amount_desc: json['amount_desc'] as int? ?? 1,
      percent_desc: json['percent_desc'] as int? ?? 1,
    );

Map<String, dynamic> _$DiscountToJson(Discount instance) => <String, dynamic>{
      'description': instance.description,
      'amount_desc': instance.amount_desc,
      'percent_desc': instance.percent_desc,
    };

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      error: json['error'] as String? ?? "",
      p_status: json['p_status'] as String? ?? "",
      redirect_url: json['redirect_url'] as String? ?? "",
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'error': instance.error,
      'p_status': instance.p_status,
      'redirect_url': instance.redirect_url,
    };

PVZData _$PVZDataFromJson(Map<String, dynamic> json) => PVZData(
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
      addr: json['addr'] as String? ?? "",
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lon: (json['lon'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$PVZDataToJson(PVZData instance) => <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'addr': instance.addr,
      'lat': instance.lat,
      'lon': instance.lon,
    };

ResponseData _$ResponseDataFromJson(Map<String, dynamic> json) => ResponseData(
      code: json['code'] as int? ?? 0,
      meta: json['meta'],
      data: json['data'] as List<dynamic>?,
    );

Map<String, dynamic> _$ResponseDataToJson(ResponseData instance) =>
    <String, dynamic>{
      'code': instance.code,
      'meta': instance.meta,
      'data': instance.data,
    };
