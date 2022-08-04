// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class Location extends StatefulWidget {
//   const Location({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<Location> createState() => _LocationState();
// }

// class _LocationState extends State<Location> {
//   String curr_add = "Press the button to update the address!";
//   double latitude = -1;
//   double longitude = -1;

//   late Position curr_position;

//   void _determinePosition() async {
//     late bool serviceEnabled;
//     late LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       Fluttertoast.showToast(msg: 'Please enable Your Location Service');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         Fluttertoast.showToast(msg: 'Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       Fluttertoast.showToast(
//           msg:
//               'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );

//     final LocationSettings locationSettings = LocationSettings(
//       accuracy: LocationAccuracy.high,
//       distanceFilter: 1,
//     );

//     StreamSubscription<Position> positionStream =
//         Geolocator.getPositionStream(locationSettings: locationSettings)
//             .listen((Position? position) {
//       // print("Inside");
//       // Fluttertoast.showToast(msg: 'Position changed');
//       setState(() {
//         curr_position = position!;
//       });
//       update_address();
//       // print(position == null ? 'Unknown' : '${position.latitude.toString()}, ${position.longitude.toString()}');
//     });

//     try {
//       setState(() {
//         curr_position = position;
//         // curr_add = "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
//       });
//       update_address();
//     } catch (e) {
//       print(e);
//     }
//   }

//   void update_address() async {
//     List<Placemark> placemarks = await placemarkFromCoordinates(
//         curr_position.latitude, curr_position.longitude);

//     Placemark place = placemarks[0];
//     print(placemarks);

//     setState(() {
//       latitude = curr_position.latitude;
//       longitude = curr_position.longitude;

//       curr_add =
//           "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.all(12),
//               child: Text(
//                 "LAT: ${latitude} \n LNG: ${longitude}",
//                 style: Theme.of(context).textTheme.headline4,
//                 // textAlign: TextAlign.center,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(12),
//               child: Text(
//                 '$curr_add',
//                 style: Theme.of(context).textTheme.headline4,
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(12),
//               child: FloatingActionButton(
//                 onPressed: _determinePosition,
//                 child: const Icon(Icons.location_pin),
//               ),
//             ),
//           ],
//         ),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
