import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluster/fluster.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:geolocator/geolocator.dart';

class SmokingEntryClusterMap extends StatefulWidget {
  @override
  _SmokingEntryClusterMapState createState() => _SmokingEntryClusterMapState();
}

class _SmokingEntryClusterMapState extends State<SmokingEntryClusterMap> {
  List<Marker> _marker = [];

  @override
  void initState() {
    super.initState();
  }

  void _createMarkser() async {
    final List<LatLng> locations = [
      LatLng(18.7970639, 99.0092428),
      LatLng(18.797267, 99.0265377),
    ];

    setState(() {
      locations.forEach((location) async {
        final icon = BitmapDescriptor.fromBytes(await getBytesFromCanvas(20));
        final marker = Marker(
          position: location,
          icon: icon,
          markerId: null,
        );

        _marker.add(marker);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final List<SmokingMarker> markers = locations
    //     .map((location) => SmokingMarker(
    //           id: locations.indexOf(location).toString(),
    //           position: location,
    //         ))
    //     .toList();

    // final Fluster fluster = Fluster<SmokingMarker>(
    //     minZoom: 0,
    //     maxZoom: 19,
    //     radius: 150,
    //     extent: 2048,
    //     nodeSize: 64,
    //     points: markers,
    //     createCluster: (BaseCluster cluster, double lng, double lat) {
    //       print('Point size: ${cluster.pointsSize}');

    //       return SmokingMarker(
    //         id: cluster.id.toString(),
    //         position: LatLng(lat, lng),
    //         isCluster: true,
    //         clusterId: cluster.id,
    //         pointsSize: cluster.pointsSize,
    //         childMarkerId: cluster.childMarkerId,
    //       );
    //     });

    // final List<Marker> googleMarkers = fluster.clusters([-180, -85, 180, 85], 13).map((cluster) {
    //   return (cluster as SmokingMarker).toMarker();
    // }).toList();

    _createMarkser();

    print(_marker);
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(18.7970639, 99.0092428),
          zoom: 15,
        ),
        markers: _marker.toSet(),
      ),
    );
  }

  Future<Uint8List> getBytesFromCanvas(int nodeSize) async {
    final PictureRecorder pictureRecorder = PictureRecorder();
    MaterialColor color = _getColor(nodeSize);
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = color[400];
    final Paint paint2 = Paint()..color = color[300];
    final Paint paint3 = Paint()..color = color[100];
    final int size = 120;
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint3);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.4, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 3.3, paint1);
    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: nodeSize.toString(),
      style: TextStyle(fontSize: size / 4, color: Colors.black, fontWeight: FontWeight.bold),
    );
    painter.layout();
    painter.paint(
      canvas,
      Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
    );

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png);
    return data.buffer.asUint8List();
  }

  MaterialColor _getColor(int size) {
    MaterialColor color;

    if (size < 10) {
      color = Colors.grey;
    } else if (size < 25) {
      color = Colors.blue;
    } else if (size < 25) {
      color = Colors.blue;
    } else if (size < 50) {
      color = Colors.green;
    } else if (size < 100) {
      color = Colors.yellow;
    } else if (size < 500) {
      color = Colors.orange;
    } else if (size < 1000) {
      color = Colors.red;
    } else {
      color = Colors.pink;
    }

    return color;
  }
}

class SmokingMarker extends Clusterable {
  final String id;
  final LatLng position;
  final BitmapDescriptor icon;

  SmokingMarker({
    @required this.id,
    @required this.position,
    @required this.icon,
    isCluster = false,
    clusterId,
    pointsSize,
    childMarkerId,
  }) : super(
          markerId: id,
          latitude: position.latitude,
          longitude: position.longitude,
          isCluster: isCluster,
          clusterId: clusterId,
          pointsSize: pointsSize,
          childMarkerId: childMarkerId,
        );

  Marker toMarker() => Marker(
        markerId: MarkerId(id),
        position: LatLng(
          position.latitude,
          position.longitude,
        ),
        icon: this.icon,
      );
}
