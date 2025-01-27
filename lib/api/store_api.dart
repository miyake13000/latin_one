import '../models/store.dart';

abstract class StoreAPI {
    Future<List<Store>> fetchStore();
}
