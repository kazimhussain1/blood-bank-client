import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/config.js.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

typedef MarkerDroppedCallback = Function(LatLng latLng);

class MapWidget extends StatefulWidget {
  const MapWidget({Key key, this.callback}) : super(key: key);

  final MarkerDroppedCallback callback;


  @override
  State<MapWidget> createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  final Completer<GoogleMapController> _controller = Completer();

  Set<Marker> markers = {};

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.8607, 67.0011),
    zoom: 14.4746,
  );

//  static final CameraPosition _kLake = CameraPosition(
//      bearing: 192.8334901395799,
//      target: LatLng(37.43296265331129, -122.08832357078792),
//      tilt: 59.440717697143555,
//      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: Container(
        height: 400.0,
        child: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: _kGooglePlex,
          markers: markers,
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
            Factory<OneSequenceGestureRecognizer>(
              () => EagerGestureRecognizer(),
            ),
          },
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          onTap: (latLng) {
            if(widget.callback != null) {
              widget.callback(latLng);
            }
            print('${latLng.latitude}, ${latLng.longitude}');
            setState(() {
              markers.clear();
              markers.add(Marker(
                markerId: MarkerId('${latLng.latitude}, ${latLng.longitude}'),
                position: latLng,
                infoWindow:
                    InfoWindow(title: 'Your Location', snippet: '${latLng.latitude}, ${latLng.longitude}'),
              ));
            });

          },
        ),
      ),
    );
  }

//  Future<void> _goToTheLake() async {
//    final controller = await _controller.future;
//    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//  }
}
