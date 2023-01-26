import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dostavka/connectors/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:location/location.dart';

import '../../models/pin_data.dart';
import '../sendings_create/summary.dart';

//Карта с офисами без onTap-a
//С иконками что-то не так, подумай, что можно с ними сделать


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

class GoogleMapScreenFirst extends StatefulWidget
{
  const GoogleMapScreenFirst({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const GoogleMapScreenFirst());
  }

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();

}


class _GoogleMapScreenState extends State<GoogleMapScreenFirst>
{

  final LatLng _initialcameraposition = const LatLng(55.75, 37.61);
  final Location _location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  Set<Marker> _markers = {};

  //Set<Circle> circles = {};


  late GoogleMapController _controller;
  late BitmapDescriptor mapMarker;
  late BitmapDescriptor myLocationMarker;

  late BitmapDescriptor mapMarkerNotActive;
  late BitmapDescriptor mapMarkerActive;
  late int isChecked = -1;
  var data;

  late double lat, long;

  late List images = [];

  var response = Api.create();

  double _pinPillPosition = -500;

  PinData _currentPinData = PinData(
      pinPath: '',
      avatarPath: '',
      location: const LatLng(0, 0),
      locationName: '',
      labelColor: Colors.grey);

  late PinData _sourcePinInfo;


  void _OnMapCreated(GoogleMapController controller) async{
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    bool isLoad = true;
    _controller = controller;
    _location.onLocationChanged.listen((l)  {
      lat = l.latitude != null ? l.latitude! : 0;
      long = l.longitude != null ? l.longitude! : 0;
      if (isLoad) {
        _controller.moveCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(lat, long), zoom: 15),
            )
        );
        isLoad = false;
      }
      _markers.clear();
      if (lat != 0 && long != 0) {
        setState(() {
          for (int i = 0; i < data.length; i++)
          {
            if (isChecked == i)
            {
              _markers.add(
                Marker(
                  markerId: MarkerId('id-$i'),
                  position: LatLng(data[i]["geo_lat"], data[i]["geo_lon"]),
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
            else
            {
              _markers.add(
                Marker(
                  markerId: MarkerId('id-$i'),
                  position: LatLng(data[i]["geo_lat"], data[i]["geo_lon"]),
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
    images.clear();

    if(data[isCheckedPin]["office_photos"].length == 0)
    {
      _sourcePinInfo = PinData(
          pinPath: 'empty',
          locationName: '${data[isCheckedPin]["address"]}',
          location: LatLng(
              lat + 0.001 * isCheckedPin, long + 0.001 * isCheckedPin),
          avatarPath: 'images/marker.png',
          labelColor: Colors.blue);
    }else if (data[isCheckedPin]["office_photos"].length >= 1) {

      for(int i = 0; i < data[isCheckedPin]["office_photos"].length; i++)
      {
        images.add('https://testarea.dostavka.info${data[isCheckedPin]["office_photos"][i]["url"]}');
      }




      _sourcePinInfo = PinData(
          pinPath: 'https://testarea.dostavka.info${data[isCheckedPin]["office_photos"][0]["url"]}',
          locationName: '${data[isCheckedPin]["address"]}',
          location: LatLng(
              lat + 0.001 * isCheckedPin, long + 0.001 * isCheckedPin),
          avatarPath: 'images/marker.png',
          labelColor: Colors.blue);
    }

  }

  void refreshTheMap(double lat, double long) {
    _markers.clear();
    for (int i = 0; i < data.length; i++)
    {
      if (isChecked == i)
      {
        _markers.add(
          Marker(
            markerId: MarkerId('id-$i'),
            position: LatLng(data[i]["geo_lat"], data[i]["geo_lon"]),
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
      else
      {
        _markers.add(
          Marker(
            markerId: MarkerId('id-$i'),
            position: LatLng(data[i]["geo_lat"], data[i]["geo_lon"]),
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

  Widget _buildLocationInfo() {
    String rText = "some text";
    // if (range >= 1000) {
    //   RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
    //   rText = (range / 1000).toStringAsFixed(1).replaceAll(regex, '') + 'км';
    // } else {
    //   rText = range.toString() + 'м';
    // }
    return Expanded(
      child: Container(
        //margin: const EdgeInsets.symmetric(horizontal: 20),
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
          ],
        ),
      ),
    );
  }





  @override
  void initState(){
    super.initState();
    setCustomMarker();
    GetAllOffices();
    CheckPermission();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  void setCustomMarker() async
  {
    final Uint8List markerIconNotActive = await getBytesFromAsset('images/marker.png', 100);
    final Uint8List markerIconActive = await getBytesFromAsset('images/orange_marker.png', 125);
    mapMarkerNotActive = BitmapDescriptor.fromBytes(markerIconNotActive);
    mapMarkerActive = BitmapDescriptor.fromBytes(markerIconActive);

    final Uint8List myLocation = await getBytesFromAsset('images/myLocation1.png', -100);
    myLocationMarker = BitmapDescriptor.fromBytes(myLocation);

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(target: _initialcameraposition, zoom: 7.5),
              mapType: MapType.normal,
              onMapCreated: _OnMapCreated,
              myLocationEnabled: false,
              markers: _markers,
              zoomControlsEnabled: false, // контролер приблежения
              myLocationButtonEnabled: false, // кнопка вверху, которая отвечает за поиск меня на карте
              compassEnabled: false, // кнопка компаса
              mapToolbarEnabled: false, // за переход в гугл мапы
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
                            var currentZoomLevel = await _controller.getZoomLevel();
                            currentZoomLevel = currentZoomLevel + 2;
                            _controller.animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  target: LatLng(lat, long),
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
                            var currentZoomLevel = await _controller.getZoomLevel();
                            currentZoomLevel = currentZoomLevel - 2;
                            if (currentZoomLevel < 0) currentZoomLevel = 0;
                            _controller.animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  target: LatLng(lat, long),
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
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.only(right: 20.0, bottom: 20.0),
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
                      Transform.rotate(
                        angle: 0.8,
                        child:  IconButton(
                            icon: const Icon(LineIcons.locationArrow),
                            onPressed: () async {
                              _controller.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: LatLng(lat, long),
                                    zoom: 15,
                                  ),
                                ),
                              );
                            }),
                      )
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
          ],
        ),
      ),
    );
  }

  Future GetAllOffices() async{
    var response = Api.create();
    final result = await response.getAllOffices();
    data = List<Map<String, dynamic>>.from(result.body);

  }

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