import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class SmokingEntryClusterMap extends StatefulWidget {
  @override
  _SmokingEntryClusterMapState createState() => _SmokingEntryClusterMapState();
}

class _SmokingEntryClusterMapState extends State<SmokingEntryClusterMap> {
  // List<Marker> _marker = [];

  @override
  void initState() {
    super.initState();
  }

  void _createMarkser() async {
    // final List<LatLng> locations = [
    //   LatLng(18.7970639, 99.0092428),
    //   LatLng(18.797267, 99.0265377),
    // ];

    setState(() {
      // locations.forEach((location) async {
      //   final icon = BitmapDescriptor.fromBytes(await getBytesFromCanvas(20));
      //   final marker = Marker(
      //     position: location,
      //     icon: icon,
      //     markerId: null,
      //   );

      //   _marker.add(marker);
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    _createMarkser();

    return Scaffold(
    
    );
  }
}

