import 'dart:developer';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dostavka/models/hive_connection/getters.dart';
import 'package:dostavka/models/hive_connection/rep_data.dart';
import 'package:dostavka/models/hive_connection/setters.dart';
import 'package:dostavka/models/hive_connection/update.dart';
import 'package:dostavka/models/pin_data.dart';
import 'package:dostavka/screens/sendings_create/summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:ui' as ui;

import '../../connectors/api.dart';

//Посмотри иконки с ними какой-то прикол .-.

class CarouselSlide extends StatelessWidget {
  const CarouselSlide({Key? key,
    required this.listImages,
  }) : super(key: key);

  final List listImages;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: CarouselSlider(
          options: CarouselOptions(
              autoPlay: false,
              height: (listImages.length == 1) ? 188.0 : 155.0,
              viewportFraction: (listImages.length == 1) ? 1 : 0.9,
              enlargeCenterPage: false,
              enableInfiniteScroll: false,
              initialPage: 0
          ),
          items: map<Widget>(listImages, (index, url) {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class GoogleMapScreenSecond extends StatefulWidget
{
  const GoogleMapScreenSecond({Key? key,
    required this.data,
  }) : super(key: key);

  static Route route(data) {
    return MaterialPageRoute<void>(builder: (_) => GoogleMapScreenSecond(data: data));
  }

  final List<Map<String, dynamic>> data;

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}


class _GoogleMapScreenState extends State<GoogleMapScreenSecond> {
  LatLng _initialcameraposition = const LatLng(55.75, 37.61);
  final Location _location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  Set<Marker> _markers = {};

  //Set<Circle> circles = {};

  late GoogleMapController _controller;
  late BitmapDescriptor mapMarkerNotActive;
  late BitmapDescriptor mapMarkerActive;
  late BitmapDescriptor myLocationMarker;
  late double lat, long;
  late User user;
  late int isChecked = -1;

  late List images = [];


  double _pinPillPosition = -500;

  PinData _currentPinData = PinData(
      pinPath: '',
      avatarPath: '',
      location: const LatLng(0, 0),
      locationName: '',
      labelColor: Colors.grey);

  late PinData _sourcePinInfo;


  void _OnMapCreated(GoogleMapController controller) {
    log('Hello world - ${widget.data}');
    bool isLoad = true;
    _controller = controller;
    _location.onLocationChanged.listen((l) {
      lat = l.latitude != null ? l.latitude! : 0;
      long = l.longitude != null ? l.longitude! : 0;
      if (isLoad) {
        _controller.moveCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(widget.data[0]['lat'], widget.data[0]['lon']), zoom: 10.5),
          ),
        );
        isLoad = false;
      }
      _markers.clear();


      //_setMapPins(lat, long, isChecked);

      if (lat != 0 && long != 0) {
        setState(() {
          print('START DRAWING');
          for (int i = 0; i < widget.data.length; i++) {
            if (isChecked == i) {
              _markers.add(
                Marker(
                  markerId: MarkerId('id-$i'),
                  position: LatLng(widget.data[i]['lat'],
                      widget.data[i]['lon']),
                  icon: mapMarkerActive,
                  onTap: () {
                    isChecked = i;
                    setState(() {
                      isChecked = i;
                      _pinPillPosition = 0;
                      _setMapPins(lat, long, isChecked);
                      _currentPinData = _sourcePinInfo;
                      refreshTheMap(lat, long);
                    });
                  },
                ),
              );
            }
            else {
              _markers.add(
                Marker(
                  markerId: MarkerId('id-$i'),
                  position: LatLng(widget.data[i]['lat'],
                      widget.data[i]['lon']),
                  icon: mapMarkerNotActive,
                  onTap: () {
                    isChecked = i;
                    setState(() {
                      isChecked = i;
                      _pinPillPosition = 0;
                      _setMapPins(lat, long, isChecked);

                      _currentPinData = _sourcePinInfo;
                      refreshTheMap(lat, long);
                    });
                  },
                ),
              );
            }
          }
        });
      }

      _markers.add(
        Marker(
          markerId: const MarkerId('id-location'),
          position: LatLng(lat, long),
          icon: myLocationMarker,
        ),
      );
    });
  }

  void _setMapPins(double latPin, double longPin, int isCheckedPin) {

      _sourcePinInfo = PinData(
          pinPath: 'empty',
          locationName: '${widget.data[isCheckedPin]['addr']}',
          location: LatLng(
              lat + 0.001 * isCheckedPin, long + 0.001 * isCheckedPin),
          labelColor: Colors.blue);
    }


  void refreshTheMap(double lat, double long) {
    _markers.clear();
    for (int i = 0; i < widget.data.length; i++) {
      if (isChecked == i) {
        _markers.add(
          Marker(
            markerId: MarkerId('id-$i'),
              position: LatLng(widget.data[i]['lat'],
                  widget.data[i]['lon']),
            icon: mapMarkerActive,
            onTap: () {
              isChecked = i;
              _pinPillPosition = 0;
              setState(() {
                _pinPillPosition = 0;
                _setMapPins(lat, long, isChecked);
                _currentPinData = _sourcePinInfo;
              });
            },
          ),
        );
      }
      else {
        _markers.add(
          Marker(
            markerId: MarkerId('id-$i'),
            position: LatLng(widget.data[i]['lat'],
                widget.data[i]['lon']),
            icon: mapMarkerNotActive,
            onTap: () {
              isChecked = i;
              setState(() {
                isChecked = i;
                _pinPillPosition = 0;
                _setMapPins(lat, long, isChecked);
                _currentPinData = _sourcePinInfo;
                refreshTheMap(lat, long);
              });
            },
          ),
        );
      }
    }

    _markers.add(
      Marker(
        markerId: const MarkerId('id-location'),
        position: LatLng(lat, long),
        icon: myLocationMarker,
      ),
    );
  }


  @override
  void initState() {
    final usr = Getters.getUser().toMap();
    if (usr.isNotEmpty) {
      user = Getters
          .getUser()
          .values
          .first;
      lat = user.lat;
      long = user.lon;
      _initialcameraposition = LatLng(lat, long);
    } else {
      lat = 0.0;
      long = 0.0;
      Setters.addUser();
      user = Getters
          .getUser()
          .values
          .first;
    }
    setCustomMarker();
    CheckPermission();
    super.initState();
  }


  Widget _buildLocationInfo() {
    String rText = '';
    if (isChecked != -1) {
      switch (widget.data[isChecked]['distance']) {
        case 0:
          {
            rText = "до 200 метров";
            break;
          }
        case 1:
          {
            rText = "до 500 метров";
            break;
          }
        case 2:
          {
            rText = "до 1 км";
            break;
          }
        case 3:
          {
            rText = "до 2 км";
            break;
          }
        case 4:
          {
            rText = "до 5 км";
            break;
          }
        case 5:
          {
            rText = "до 10 км";
            break;
          }
        case 6:
          {
            rText = "до 20 км";
            break;
          }
        case 7:
          {
            rText = "свыше 20 км";
            break;
          }
        default:
          rText = "недалеко";
          break;
      }
    }

    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.all(10),
              child: Card(
                color: const Color.fromRGBO(226, 229, 234, 1.0),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color.fromRGBO(
                      226, 229, 234, 1.0), width: 1),
                  borderRadius: BorderRadius.circular(12.5),
                ),
                child: Container(
                  color: const Color.fromRGBO(45, 58, 82, 0.5).withOpacity(0),
                  width: 25,
                  height: 25,
                  child: Column(
                    children: <Widget>[
                      Transform.rotate(
                          angle: 0.8,
                          child:
                          SizedBox(
                            height: 25.0,
                            width: 25.0,
                            child: IconButton(
                              padding: const EdgeInsets.all(0.0),
                              icon: const Icon(Icons.add, size: 18.75),
                              onPressed: () {
                                setState(() {
                                  refreshThePin();
                                });
                              },
                            ),
                          )
                      )
                    ],
                  ),
                ),
              ),
            ),
            if (images.isNotEmpty) ...[
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: CarouselSlide(listImages: images),
              ),
            ],
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                _currentPinData.locationName,
                style: const TextStyle(fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Exo2.0",
                    color: Color(0xFF2D3A52)),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const SizedBox(height: 20),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText(
                text: TextSpan(
                    style: const TextStyle(
                      fontFamily: 'Exo2.0',
                      fontWeight: FontWeight.w400,
                      fontSize: 15.0,
                      color: Color(0xFF2D3A52),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: rText,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFF0674C),
                        ),
                      ),
                      const TextSpan(
                        text: ' от получателя',
                      ),
                    ]
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const SizedBox(height: 20),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  alignment: Alignment.center,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(Summary.route());
                  },
                  color: const Color(0xFFF0674C),
                  disabledColor: const Color.fromRGBO(240, 103, 76, 0.3),
                  pressedOpacity: 0.4,
                  padding: const EdgeInsets.all(17.0),
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  child: const Text(
                    "Выбрать этот пункт",
                    style: TextStyle(fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const SizedBox(height: 20),
            ),
            // Text(
            //   'Latitude : ${_currentPinData.location.latitude}',
            // ),
            // SizedBox(height: 10),
            // Text(
            //   'Longitude : ${_currentPinData.location.longitude}',
            // )
          ],
        ),
      ),
    );
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer
        .asUint8List();
  }

  void setCustomMarker() async
  {
    final Uint8List markerIconNotActive = await getBytesFromAsset(
        'images/marker.png', 100);
    final Uint8List markerIconActive = await getBytesFromAsset(
        'images/orange_marker.png', 125);
    mapMarkerNotActive = BitmapDescriptor.fromBytes(markerIconNotActive);
    mapMarkerActive = BitmapDescriptor.fromBytes(markerIconActive);

    final Uint8List myLocation = await getBytesFromAsset(
        'images/myLocation1.png', -100);
    myLocationMarker = BitmapDescriptor.fromBytes(myLocation);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(widget.data[0]['lat'], widget.data[0]['lon']), zoom: 10.5),
                mapType: MapType.normal,
                onMapCreated: _OnMapCreated,
                myLocationEnabled: false,
                markers: _markers,
                zoomControlsEnabled: false,
                // контролер приблежения
                myLocationButtonEnabled: false,
                // кнопка вверху, которая отвечает за поиск меня на карте
                compassEnabled: false,
                // кнопка компаса
                mapToolbarEnabled: false,
                // за переход в гугл мапы
                onTap: (LatLng location) {
                  setState(() {
                    refreshThePin();
                  });
                },
              ),

              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(right: 20.0, bottom: 55.0),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Container(
                    color: const Color(0x00ffffff).withOpacity(0),
                    width: 50,
                    height: 50,
                    child: Column(
                      children: <Widget>[
                        IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () async {
                              var currentZoomLevel = await _controller
                                  .getZoomLevel();
                              currentZoomLevel = currentZoomLevel + 2;
                              _controller.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: LatLng(widget.data[0]['lat'], widget.data[0]['lon']),
                                    zoom: currentZoomLevel,
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ),


              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(right: 20.0, top: 55.0),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Container(
                    color: const Color(0x00ffffff).withOpacity(0),
                    width: 50,
                    height: 50,
                    child: Column(
                      children: <Widget>[
                        IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () async {
                              var currentZoomLevel = await _controller
                                  .getZoomLevel();
                              currentZoomLevel = currentZoomLevel - 2;
                              if (currentZoomLevel < 0) currentZoomLevel = 0;
                              _controller.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: LatLng(widget.data[0]['lat'], widget.data[0]['lon']),
                                    zoom: currentZoomLevel,
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ),

              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(left: 20.0, top: 30.0),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Container(
                    color: const Color(0x00ffffff).withOpacity(0),
                    width: 50,
                    height: 50,
                    child: Column(
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                      ],
                    ),
                  ),
                ),
              ),


              AnimatedPositioned(
                bottom: _pinPillPosition,
                right: 0,
                left: 0,
                duration: const Duration(milliseconds: 200),
                child: Align(
                    alignment: Alignment.bottomCenter,

                    child: Wrap(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(20),
                          //height: 170,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              _buildLocationInfo(),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
              ),
            ]
        ),
      ),
    );
  }
  //
  // void GetOffices() async {
  //   var response = Api.create();
  //   if (lat == 0.0 && long == 0.0) {
  //     await _location.getLocation().then((l) async {
  //       Update.EditUser(user, lat: l.latitude ?? 0.0, lon: l.longitude ?? 0.0);
  //       var body = {"geo_lon": "${user.lon}", "geo_lat": "${user.lat}"};
  //       final result = await response.getOffices(body);
  //       data = new List<Map<String, dynamic>>.from(result.body);
  //     });
  //   } else {
  //     var body = {"geo_lon": "${user.lon}", "geo_lat": "${user.lat}"};
  //     final result = await response.getOffices(body);
  //     data = List<Map<String, dynamic>>.from(result.body);
  //   }
  // }


  void refreshThePin() {
    _pinPillPosition = -500;
    isChecked = -1;
    images.clear();
    refreshTheMap(lat, long);
  }

  Future<void> CheckPermission() async {
    _serviceEnabled = await _location.serviceEnabled();
    print("check service enable - $_serviceEnabled");
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    print("check permission granted - $_permissionGranted");
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }
}
