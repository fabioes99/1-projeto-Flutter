import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocalizationPage extends StatefulWidget {
  const LocalizationPage({super.key});

  @override
  State<LocalizationPage> createState() => _LocalizationPageState();
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  return await Geolocator.getCurrentPosition();
}

class _LocalizationPageState extends State<LocalizationPage> {
  String latitude = '';
  String longitude = '';
 

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold( 
      appBar: AppBar(title: const Text('Localização'),),
      body: Center(
        child: Column(children: [
          ElevatedButton(onPressed: () async{
            Position position =  await _determinePosition();
            latitude = position.latitude.toStringAsFixed(2);
            longitude = position.longitude.toStringAsFixed(2);
            setState(() {
            });
          }, child: const Text('localize se')),
          latitude.isNotEmpty && longitude.isNotEmpty ? Text(" Latitude = $latitude, Longitude = $longitude ") : Text('')
        ],
        ),
      )
      ),);
  }
}