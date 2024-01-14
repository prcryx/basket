class ProductEntity {
  String? sId;
  String? name;
  int? quantity;
  int? price;
  String? description;
  List<String>? images;
  int? discountedPrice;
  String? category;
  String? subcategory;
  int? stock;
  List<String>? details;
  int? numOfReviews;
  List<String>? reviews;
  String? createdAt;
  int? iV;
  String? type;

  ProductEntity(
      {this.sId,
      this.name,
      this.quantity,
      this.price,
      this.description,
      this.images,
      this.discountedPrice,
      this.category,
      this.subcategory,
      this.stock,
      this.details,
      this.numOfReviews,
      this.reviews,
      this.createdAt,
      this.iV,
      this.type});

  ProductEntity.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    description = json['description'];
    images = json['images'].cast<String>();
    discountedPrice = json['discountedPrice'];
    category = json['category'];
    subcategory = json['subcategory'];
    stock = json['stock'];
    details = json['details'].cast<String>();
    numOfReviews = json['numOfReviews'];
    reviews = json['reviews'].cast<String>();
    createdAt = json['createdAt'];
    iV = json['__v'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['quantity'] = quantity;
    data['price'] = price;
    data['description'] = description;
    data['images'] = images;
    data['discountedPrice'] = discountedPrice;
    data['category'] = category;
    data['subcategory'] = subcategory;
    data['stock'] = stock;
    data['details'] = details;
    data['numOfReviews'] = numOfReviews;
    data['reviews'] = reviews;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    data['type'] = type;
    return data;
  }
}
