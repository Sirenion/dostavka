
import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class PinData {
  late String pinPath;
  late String avatarPath;
  late LatLng location;
  late String locationName;
  late Color labelColor;

  PinData({required this.pinPath, this.avatarPath = '', required this.location, required this.locationName,
      required this.labelColor});
}