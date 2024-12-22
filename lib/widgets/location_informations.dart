import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart';

class LocationInformations extends StatefulWidget {
  const LocationInformations({super.key});

  @override
  State<LocationInformations> createState() => _LocationInformationsState();
}

class _LocationInformationsState extends State<LocationInformations> {
  String locationInfo = 'Konum bilgisi alınıyor...';
  LocationData? currentLocation;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      Location location = Location();
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          setState(() {
            locationInfo = 'Konum servisi etkin değil.';
          });
          return;
        }
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          setState(() {
            locationInfo = 'Konum izni verilmedi.';
          });
          return;
        }
      }

      final currentLocation = await location.getLocation();

      final placemarks = await geocoding.placemarkFromCoordinates(
        currentLocation.latitude!,
        currentLocation.longitude!,
      );

      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        setState(() {
          locationInfo =
              '${placemark.administrativeArea}/${placemark.locality}';
        });
      } else {
        setState(() {
          locationInfo = 'Adres bilgisi bulunamadı.';
        });
      }
    } catch (e) {
      setState(() {
        locationInfo = 'Konum bilgisi alınırken bir hata oluştu: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(locationInfo),
        if (currentLocation != null) Text('$currentLocation'),
      ],
    );
  }
}
