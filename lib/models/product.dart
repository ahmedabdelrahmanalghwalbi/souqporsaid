class Product {
  String name;
  String description;
  String richDescription;
  String image;
  String images;
  String brand;
  int price;
  String category;
  int countInStock;
  int rating;
  bool isFeatured;
  String dataCreated;

  Product(
      {this.name,
        this.description,
        this.richDescription,
        this.image,
        this.images,
        this.brand,
        this.price,
        this.category,
        this.countInStock,
        this.rating,
        this.isFeatured,
        this.dataCreated});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    richDescription = json['richDescription'];
    image = json['image'];
    images = json['images'];
    brand = json['brand'];
    price = json['price'];
    category = json['category'];
    countInStock = json['countInStock'];
    rating = json['rating'];
    isFeatured = json['isFeatured'];
    dataCreated = json['dataCreated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['richDescription'] = this.richDescription;
    data['image'] = this.image;
    data['images'] = this.images;
    data['brand'] = this.brand;
    data['price'] = this.price;
    data['category'] = this.category;
    data['countInStock'] = this.countInStock;
    data['rating'] = this.rating;
    data['isFeatured'] = this.isFeatured;
    data['dataCreated'] = this.dataCreated;
    return data;
  }
}