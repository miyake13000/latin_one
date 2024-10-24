import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';
import '../resources/order.dart' as order;
import '../resources/store.dart';
import '../db/firebase/connector.dart';

class StorePage extends StatelessWidget {
  StorePage({super.key});
  Future<List<Store>> future = fetchStore(FirebaseFirestore.instance);

  @override
    Widget build(BuildContext context) {
      return FutureBuilder<List<Store>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          }

          List<Store> stores = snapshot.data!;
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
    final orderData = Provider.of<order.Order>(ctx, listen: false);

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
                  orderData.changeStore(store),
                  Navigator.pop(context),
                  GoRouter.of(context).go('/order'),
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
