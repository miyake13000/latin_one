import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

const stores = [
  Store(
    'お店1',
    LatLng(30.0, 30.0),
    'とある県どっか地方',
    '000-0000-0000',
    '10:00 - 17:00',
    '水，土，日'
  )
];

class Store {
  final String name;
  final LatLng location;
  final String address;
  final String phoneNumber;
  final String openingHours;
  final String holiday;

  const Store(
      this.name,
      this.location,
      this.address,
      this.phoneNumber,
      this.openingHours,
      this.holiday
      );
}

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: stores[0].location,
        initialZoom: 15.0,
      ),
      children: [
        // Map Tile
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',          userAgentPackageName: 'com.latin_one.app',
          maxNativeZoom: 19,
        ),

        // Store location
        MarkerLayer(markers: createMarkers(context, stores)),

        // Attribution
        const RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
            ),
          ],
        ),
      ],
    );
  }

  List<Marker> createMarkers(BuildContext ctx, List<Store> stores) {
    var markers = <Marker>[];
    for (var store in stores) {
      markers.add(Marker(
        point: store.location,
        child: GestureDetector(
          onTap: () {
            showStoreInfo(store, ctx);
          },
          behavior: HitTestBehavior.opaque,
          child:  const Icon(
            Icons.location_on,
            color: Colors.red,
            size: 40,
          ),
        )
      ));
    }
    return markers;
  }

  void showStoreInfo(Store store, BuildContext ctx) {
    showModalBottomSheet<void>(
      context: ctx,
      builder: (BuildContext context) {
        return SizedBox(
          height: 400,
          child: SingleChildScrollView(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.store),
                title: const Text('店名'),
                subtitle: Text(store.name),
              ),
              ListTile(
                leading: const Icon(Icons.map),
                title: const Text('住所'),
                subtitle: Text(store.address),
              ),
              ListTile(
                leading: const Icon(Icons.call),
                title: const Text('電話'),
                subtitle: Text(store.phoneNumber),
              ),
              ListTile(
                leading: const Icon(Icons.schedule),
                title: const Text('営業時間'),
                subtitle: Text(store.openingHours),
              ),
              ListTile(
                leading: const Icon(Icons.event_busy),
                title: const Text('定休日'),
                subtitle: Text(store.holiday),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          )),
        );
      },
    );
  }
}