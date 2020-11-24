import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

typedef MarkerDroppedCallback = Function(LatLng latLng);

class MapWidget extends StatefulWidget {
  const MapWidget({Key key, this.callback, this.label = ''}) : super(key: key);

  final String label;
  final MarkerDroppedCallback callback;

  @override
  State<MapWidget> createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  final Completer<GoogleMapController> _controller = Completer();

  Set<Marker> markers = {};

  static final CameraPosition karachi = CameraPosition(
    target: LatLng(24.8607, 67.0011),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: Container(
        decoration: const ShapeDecoration(
            shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Text(
                widget.label,
                style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
              ),
            ),
            Container(
              height: 400,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: karachi,
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
                  if (widget.callback != null) {
                    widget.callback(latLng);
                  }
//                  print('${latLng.latitude}, ${latLng.longitude}');
                  setState(() {
                    markers.clear();
                    markers.add(Marker(
                      markerId: MarkerId('${latLng.latitude}, ${latLng.longitude}'),
                      position: latLng,
                      infoWindow: InfoWindow(
                          title: 'Your Location',
                          snippet: '${latLng.latitude}, ${latLng.longitude}'),
                    ));
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

//  Future<void> _goToTheLake() async {
//    final controller = await _controller.future;
//    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//  }
}
