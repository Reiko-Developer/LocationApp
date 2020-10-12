import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;
  final bool withInitialMarker;

  MapScreen({
    this.initialLocation =
        const PlaceLocation(latitude: 37.422, longitude: -122.084),
    this.isSelecting = false,
    this.withInitialMarker = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    //No caso de PlaceDetailScreen chamar a classe MapScreen
    //No qual já deverá ter um marcador pré-estabelecido no mapa.
    if (widget.withInitialMarker) {
      _selectLocation(LatLng(
          widget.initialLocation.latitude, widget.initialLocation.longitude));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Your map'),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _pickedLocation == null
                  ? null
                  : () => Navigator.of(context).pop(_pickedLocation),
            )
        ],
      ),
      //GoogleMap() assumes the height and width of the parent widget.
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: _pickedLocation == null
            ? null
            : {
                Marker(markerId: MarkerId('m1'), position: _pickedLocation),
              },
      ),
    );
  }
}
