import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/order_controller.dart';
import '../models/store.dart';
import '../providers.dart';

class StorePage extends ConsumerWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeFuture = ref.watch(storeProvider);
    final orderNotifier = ref.watch(orderProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('店舗ページ'),
      ),
      body: storeFuture.when(
        data: (stores) => FlutterMap(
          options: MapOptions(
            initialCenter: stores[0].location,
            initialZoom: 15.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.latin_one.app',
              maxNativeZoom: 19,
            ),

            // Store location
            MarkerLayer(markers: createMarkers(context, stores, orderNotifier)),

            // Attribution
            const RichAttributionWidget(
              attributions: [
                TextSourceAttribution(
                  'OpenStreetMap contributors',
                ),
              ],
            ),
          ],
        ),
        error: (error, stack) => Center(
          child: Text('エラーが発生しました: ${error.toString()}'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  List<Marker> createMarkers(BuildContext ctx, List<Store> stores, OrderController order) {
    var markers = <Marker>[];
    for (var store in stores) {
      markers.add(Marker(
            point: store.location,
            child: GestureDetector(
          onTap: () {
            showStoreInfo(store, ctx, order);
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

  void showStoreInfo(Store store, BuildContext ctx, OrderController order) {
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
                  order.changeStore(store),
                  GoRouter.of(context).push('/product'),
                  // GoRouter.of(context).go('/order'),
                  context.pop(),
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
