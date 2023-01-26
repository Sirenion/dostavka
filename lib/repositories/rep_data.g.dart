// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rep_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CookieAdapter extends TypeAdapter<Cookie> {
  @override
  final int typeId = 1;

  @override
  Cookie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cookie(
      csrftoken: fields[1] == null ? '' : fields[1] as String,
      sessionid: fields[2] == null ? '' : fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Cookie obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.csrftoken)
      ..writeByte(2)
      ..write(obj.sessionid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CookieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SuggestAdapter extends TypeAdapter<Suggest> {
  @override
  final int typeId = 2;

  @override
  Suggest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Suggest(
      url: fields[1] == null ? '' : fields[1] as String,
      token: fields[2] == null ? '' : fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Suggest obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SuggestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AuthAdapter extends TypeAdapter<Auth> {
  @override
  final int typeId = 3;

  @override
  Auth read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Auth(
      is_login: fields[1] == null ? false : fields[1] as bool,
      sessionid: fields[2] == null ? '' : fields[2] as String,
      token: fields[3] == null ? '' : fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Auth obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.is_login)
      ..writeByte(2)
      ..write(obj.sessionid)
      ..writeByte(3)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AddressAdapter extends TypeAdapter<Address> {
  @override
  final int typeId = 4;

  @override
  Address read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Address(
      address: fields[1] == null ? '' : fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Address obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 5;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      username: fields[1] == null ? '' : fields[1] as String,
      user_editable: fields[2] == null ? false : fields[2] as bool,
      user_type: fields[3] == null ? 1 : fields[3] as int,
      first_name: fields[4] == null ? '' : fields[4] as String,
      second_name: fields[5] == null ? '' : fields[5] as String,
      last_name: fields[6] == null ? '' : fields[6] as String,
      full_name: fields[7] == null ? '' : fields[7] as String,
      passport_editable: fields[8] == null ? false : fields[8] as bool,
      passport_number: fields[9] == null ? '' : fields[9] as String,
      address_editable: fields[10] == null ? false : fields[10] as bool,
      token: fields[11] == null ? '' : fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(11)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.user_editable)
      ..writeByte(3)
      ..write(obj.user_type)
      ..writeByte(4)
      ..write(obj.first_name)
      ..writeByte(5)
      ..write(obj.second_name)
      ..writeByte(6)
      ..write(obj.last_name)
      ..writeByte(7)
      ..write(obj.full_name)
      ..writeByte(8)
      ..write(obj.passport_editable)
      ..writeByte(9)
      ..write(obj.passport_number)
      ..writeByte(10)
      ..write(obj.address_editable)
      ..writeByte(11)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OfficesAdapter extends TypeAdapter<Offices> {
  @override
  final int typeId = 6;

  @override
  Offices read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Offices(
      address: fields[1] == null ? '' : fields[1] as String,
      geo_lon: fields[2] == null ? 0.0 : fields[2] as double,
      geo_lat: fields[3] == null ? 0.0 : fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Offices obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.geo_lon)
      ..writeByte(3)
      ..write(obj.geo_lat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfficesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SecurityAdapter extends TypeAdapter<Security> {
  @override
  final int typeId = 7;

  @override
  Security read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Security(
      username: fields[1] == null ? '' : fields[1] as String,
      security_code: fields[2] == null ? '' : fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Security obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.security_code);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SecurityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DraftsAdapter extends TypeAdapter<Drafts> {
  @override
  final int typeId = 8;

  @override
  Drafts read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Drafts(
      number: fields[1] == null ? 1 : fields[1] as int,
      user_from: fields[2] == null ? '' : fields[2] as String,
      user_to: fields[3] == null ? '' : fields[3] as String,
      date_create: fields[4] == null ? '' : fields[4] as String,
      office_from: fields[5] == null ? '' : fields[5] as String,
      cargo: fields[6] == null ? '' : fields[6] as String,
      status: fields[7] == null ? '' : fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Drafts obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.user_from)
      ..writeByte(3)
      ..write(obj.user_to)
      ..writeByte(4)
      ..write(obj.date_create)
      ..writeByte(5)
      ..write(obj.office_from)
      ..writeByte(6)
      ..write(obj.cargo)
      ..writeByte(7)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DraftsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DraftAdapter extends TypeAdapter<Draft> {
  @override
  final int typeId = 9;

  @override
  Draft read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Draft(
      number: fields[1] == null ? 1 : fields[1] as int,
      user_from: fields[2] == null ? '' : fields[2] as String,
      user_to: fields[3] == null ? '' : fields[3] as String,
      date_create: fields[4] == null ? '' : fields[4] as String,
      payment: fields[5] == null ? false : fields[5] as bool,
      office_from: fields[6] == null ? '' : fields[6] as String,
      submit: fields[7] == null ? false : fields[7] as bool,
      by_user_to: fields[8] == null ? false : fields[8] as bool,
      courier_bring: fields[9] == null ? false : fields[9] as bool,
      returned: fields[10] == null ? false : fields[10] as bool,
      free_keep: fields[11] == null ? '' : fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Draft obj) {
    writer
      ..writeByte(11)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.user_from)
      ..writeByte(3)
      ..write(obj.user_to)
      ..writeByte(4)
      ..write(obj.date_create)
      ..writeByte(5)
      ..write(obj.payment)
      ..writeByte(6)
      ..write(obj.office_from)
      ..writeByte(7)
      ..write(obj.submit)
      ..writeByte(8)
      ..write(obj.by_user_to)
      ..writeByte(9)
      ..write(obj.courier_bring)
      ..writeByte(10)
      ..write(obj.returned)
      ..writeByte(11)
      ..write(obj.free_keep);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DraftAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CargoAdapter extends TypeAdapter<Cargo> {
  @override
  final int typeId = 10;

  @override
  Cargo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cargo(
      uuid: fields[1] == null ? '' : fields[1] as String,
      editable: fields[2] == null ? false : fields[2] as bool,
      need_pack: fields[3] == null ? false : fields[3] as bool,
      name: fields[4] == null ? '' : fields[4] as String,
      height: fields[5] == null ? 0.0 : fields[5] as double,
      width: fields[6] == null ? 0.0 : fields[6] as double,
      length: fields[7] == null ? 0.0 : fields[7] as double,
      weigh: fields[8] == null ? 0.0 : fields[8] as double,
      declared_value: fields[9] == null ? 0.0 : fields[9] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Cargo obj) {
    writer
      ..writeByte(9)
      ..writeByte(1)
      ..write(obj.uuid)
      ..writeByte(2)
      ..write(obj.editable)
      ..writeByte(3)
      ..write(obj.need_pack)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.height)
      ..writeByte(6)
      ..write(obj.width)
      ..writeByte(7)
      ..write(obj.length)
      ..writeByte(8)
      ..write(obj.weigh)
      ..writeByte(9)
      ..write(obj.declared_value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CargoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PromoAdapter extends TypeAdapter<Promo> {
  @override
  final int typeId = 11;

  @override
  Promo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Promo(
      valid: fields[1] == null ? false : fields[1] as bool,
      detail: fields[2] == null ? '' : fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Promo obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.valid)
      ..writeByte(2)
      ..write(obj.detail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PromoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OrdersAdapter extends TypeAdapter<Orders> {
  @override
  final int typeId = 12;

  @override
  Orders read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Orders(
      number: fields[1] == null ? 1 : fields[1] as int,
      user_from: fields[2] == null ? '' : fields[2] as String,
      user_to: fields[3] == null ? '' : fields[3] as String,
      date_create: fields[4] == null ? '' : fields[4] as String,
      office_from: fields[5] == null ? '' : fields[5] as String,
      cargo: fields[6] == null ? '' : fields[6] as String,
      status: fields[7] == null ? '' : fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Orders obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.user_from)
      ..writeByte(3)
      ..write(obj.user_to)
      ..writeByte(4)
      ..write(obj.date_create)
      ..writeByte(5)
      ..write(obj.office_from)
      ..writeByte(6)
      ..write(obj.cargo)
      ..writeByte(7)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrdersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OrderAdapter extends TypeAdapter<Order> {
  @override
  final int typeId = 13;

  @override
  Order read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Order(
      number: fields[1] == null ? 1 : fields[1] as int,
      user_from: fields[2] == null ? '' : fields[2] as String,
      user_to: fields[3] == null ? '' : fields[3] as String,
      date_create: fields[4] == null ? '' : fields[4] as String,
      office_from: fields[5] == null ? '' : fields[5] as String,
      cargo: fields[6] == null ? '' : fields[6] as String,
      status: fields[7] == null ? '' : fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Order obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.user_from)
      ..writeByte(3)
      ..write(obj.user_to)
      ..writeByte(4)
      ..write(obj.date_create)
      ..writeByte(5)
      ..write(obj.office_from)
      ..writeByte(6)
      ..write(obj.cargo)
      ..writeByte(7)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
