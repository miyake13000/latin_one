class Product {
  final int    id;
  final String name;
  final String description;
  final int    price;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image
  });

  Product.fromMap(Map<String, dynamic> map)
      : this(
              id          : map['id'],
              name        : map['name'],
              description : map['description'],
              price       : map['price'],
              image       : map['image'],
            );

  static String collectionPath() {
    return '/products';
  }
}
