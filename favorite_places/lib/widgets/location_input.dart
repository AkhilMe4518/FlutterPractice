import 'dart:convert';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onselectLocation});

  final void Function(PlaceLocation location) onselectLocation;

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  var _isGettingLocation = false;

  String get locationImage {
    final lat = _pickedLocation!.latitude;
    final long = _pickedLocation!.longitude;
    if (_pickedLocation == null) {
      // print("location null");
      return '';
    }
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long=&zoom=16&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C$lat,$long&key=AIzaSyDLcwxUggpPZo8lcbH0TB4Crq5SJjtj4ag';
  }

  Future<void> _savePlace(double latitude, double longitude) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyDLcwxUggpPZo8lcbH0TB4Crq5SJjtj4ag');
    final response = await http.get(url);
    // print(response);
    // print("past url");
    final resData = json.decode(response.body);
    final address = resData['results'][0]['formatted_address'];

    setState(() {
      _pickedLocation = PlaceLocation(
        latitude: latitude,
        longitude: longitude,
        address: address,
      );
      _isGettingLocation = false;
    });
    widget.onselectLocation(_pickedLocation!);
    // print(locationData.latitude);
  }

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();
    // AIzaSyByu4cgVque_p8xrfMql31T3lKNtCm9KTk
    //AIzaSyDLcwxUggpPZo8lcbH0TB4Crq5SJjtj4ag
    final lat = locationData.latitude;
    final long = locationData.longitude;

    if (lat == null || long == null) {
      return;
    }
    // print("coordinates fetched");
    _savePlace(lat, long);
  }

  void _selectOnMap() async {
    final pickedLocation = await Navigator.of(context)
        .push<LatLng>(MaterialPageRoute(builder: (ctx) => const MapScreen()));

    if (pickedLocation == null) {
      return;
    }
    // print("not null*******************");
    _savePlace(pickedLocation.latitude, pickedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    Widget previwContent = Text(
      "No location chosen!",
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );
    if (_pickedLocation != null) {
      print("insidePicked location : $locationImage");
      previwContent = Image.network(
        locationImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    if (_isGettingLocation) {
      previwContent = CircularProgressIndicator();
    }

    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: Theme.of(context).colorScheme.primary),
          ),
          child: previwContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
                onPressed: () {
                  _getCurrentLocation();
                },
                icon: Icon(Icons.location_on),
                label: Text("Get current location")),
            TextButton.icon(
                onPressed: () {
                  _selectOnMap();
                },
                icon: Icon(Icons.map),
                label: Text("Select on map")),
          ],
        )
      ],
    );
  }
}
