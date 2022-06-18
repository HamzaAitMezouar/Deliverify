import 'package:deliverify/src/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  Position position;
  String city;
  MapWidget({Key? key, required this.position, required this.city})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<MapWidget> createState() =>
      _MapWidgetState(position: position, city: city);
}

class _MapWidgetState extends State<MapWidget> {
  Position position;
  String city;
  _MapWidgetState({required this.position, required this.city});

  Set<Marker> marker = {};
  late BitmapDescriptor mapMarker;
  bool loading = true;
  void setMarkerIcon() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/pin.png');
  }

  onMapCreated(GoogleMapController googleMapController) {
    setState(() {
      marker.add(
        Marker(
            icon: mapMarker,
            infoWindow: InfoWindow(title: city),
            markerId: const MarkerId('1'),
            position: LatLng(position.latitude, position.longitude)),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    setMarkerIcon();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        loading = false;
      });
    });
    print(city);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Location'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(
                color: lightIcon,
              ),
            )
          : GoogleMap(
              onMapCreated: onMapCreated,
              markers: marker,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                  zoom: 18,
                  target: LatLng(position.latitude, position.longitude)),
            ),
    );
  }
}
