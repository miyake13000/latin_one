import '../models/product.dart';

abstract class ProductAPI {
    Future<List<Product>> fetchProduct();
}
