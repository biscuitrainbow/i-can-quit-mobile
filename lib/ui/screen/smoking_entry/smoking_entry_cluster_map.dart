import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:meta/meta.dart';
import 'package:flutter_map/flutter_map.dart';

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
      body: FlutterMap(
        options: new MapOptions(
          // center: new LatLng(51.5, -0.09),
          zoom: 13.0,
          plugins: [
            MyCustomPlugin(),
          ],
        ),
        layers: [
          new TileLayerOptions(
            urlTemplate: "https://api.tiles.mapbox.com/v4/"
                "{id}/{z}/{x}/{y}@2x.png?access_token=pk.eyJ1IjoiYmlzY3VpdHJhaW5ib3ciLCJhIjoiY2prdHNxN3YyMDlobDN2cGJ0aGdmOHk3YyJ9.Bf6KFoZAsx6rGa7h5Cl_og",
            additionalOptions: {
              'accessToken': 'pk.eyJ1IjoiYmlzY3VpdHJhaW5ib3ciLCJhIjoiY2prdHNxN3YyMDlobDN2cGJ0aGdmOHk3YyJ9.Bf6KFoZAsx6rGa7h5Cl_og',
              'id': 'mapbox.streets',
            },
          ),
          MyCustomPluginOptions(text: "I'm a plugin!"),
          new MarkerLayerOptions(
            markers: [
              new Marker(
                width: 80.0,
                height: 80.0,
                // point: new LatLng(51.5, -0.09),
                builder: (ctx) => new Container(
                  child: new FlutterLogo(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
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

class MyCustomPluginOptions extends LayerOptions {
  final String text;
  MyCustomPluginOptions({this.text = ''});
}

class MyCustomPlugin implements MapPlugin {
  @override
  Widget createLayer(LayerOptions options, MapState mapState, Stream<Null> stream) {
    if (options is MyCustomPluginOptions) {
      var style = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24.0,
        color: Colors.red,
      );

      return Text(
        options.text,
        style: style,
      );
    }
    throw Exception('Unknown options type for MyCustom'
        'plugin: $options');
  }

  @override
  bool supportsLayer(LayerOptions options) {
    return options is MyCustomPluginOptions;
  }
}
