class TemporaryUser {
  String name;
  String secName;
  String famName;
  String phone;
  String? pin;
  String city;
  String street;
  String building;
  String buildingAdditional;
  String apartment;
  String password;
  bool? biometric;

  TemporaryUser(
      {
        required this.name,
        required this.secName,
        required this.famName,
        required this.phone,
        this.pin,
        required this.city,
        required this.street,
        required this.building,
        required this.buildingAdditional,
        required this.apartment,
        required this.password,
        this.biometric
      });
}
