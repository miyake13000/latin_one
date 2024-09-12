import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'order.dart';
import 'store.dart';

const stores = [
  Store(
    0,
    'お店1',
    LatLng(30.0, 30.0),
    'とある県どっか地方',
    '000-0000-0000',
    '10:00 - 17:00',
    '水，土，日'
  )
];

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
    final orderData = Provider.of<Order>(ctx, listen: false);

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
                onTap: () => _makePhoneCall(store.phoneNumber),
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
                onPressed: () => {
                  orderData.changeStore(store.id),
                },
                child: const Text('この店舗を選択'),
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

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }
  }
}
