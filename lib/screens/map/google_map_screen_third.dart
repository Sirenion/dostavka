import 'package:location/location.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//Карта, где показан выбранный пункт отправления
//Убран обработчик

class GoogleMapScreenThird extends StatefulWidget {
  const GoogleMapScreenThird({Key? key}) : super(key: key);


  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const GoogleMapScreenThird());
  }

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();

}

class _GoogleMapScreenState extends State<GoogleMapScreenThird>
{

  final LatLng _initialcameraposition = const LatLng(53.9, 27.33);
  late GoogleMapController _controller;
  final Location _location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  Set<Marker> _markers = {};

  late BitmapDescriptor mapMarker;
  late BitmapDescriptor myLocationMarker;
  //Пока засуну координаты минска
  late double lat1 = 53.53, long1 = 27.34;


  void _OnMapCreated(GoogleMapController controller)
  {
    _controller = controller;
    _controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat1, long1),zoom: 10),
      ),
    );
      setState(() {
        _markers.add(
          Marker(
            markerId: const MarkerId('id-1'),
            position: LatLng(lat1, long1),
            icon: mapMarker,
            // onTap: () {
            //   var snackBar = SnackBar(content: Text('tap on 1'));
            //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
            // },
          ),
        );

      });

    _location.onLocationChanged.listen((l) {
      double lat = l.latitude != null ? l.latitude! : 0;
      double long = l.longitude != null ? l.longitude! : 0;
      setState(() {
        _markers.clear();
        _markers.add(
          Marker(
            markerId: const MarkerId('id-location'),
            position: LatLng(lat, long),
            icon: myLocationMarker,
          ),
        );
        _markers.add(
          Marker(
            markerId: const MarkerId('id-1'),
            position: LatLng(lat1, long1),
            icon: mapMarker,
            // onTap: () {
            //   var snackBar = SnackBar(content: Text('tap on 1'));
            //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
            // },
          ),
        );
      });
    });

  }

  @override
  void initState(){
    super.initState();
    setCustomMarker();
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
    final Uint8List markerIconNotActive = await getBytesFromAsset('images/orange_marker.png', 100);
    mapMarker = BitmapDescriptor.fromBytes(markerIconNotActive);

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
                                  target: LatLng(lat1, long1),
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
                                  target: LatLng(lat1, long1),
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

          ],
        ),
      ),
    );
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