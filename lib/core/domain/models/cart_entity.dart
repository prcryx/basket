class CartEntity {
  Cart? cart;
  CartSummary? cartSummary;

  CartEntity({this.cart, this.cartSummary});

  CartEntity.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ? Cart.fromJson(json['cart']) : null;
    cartSummary =
        json['totals'] != null ? CartSummary.fromJson(json['totals']) : null;
  }
}

class Cart {
  String? sId;
  String? userId;
  List<CartProduct>? cartPoduct;
  String? code;
  String? couponDiscount;
  String? shippingAmount;
  String? subtotal;
  String? taxAmount;
  String? discountAmount;
  String? subtotalAmount;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? totalAmount;
  String? couponCode;

  Cart({
    this.sId,
    this.userId,
    this.cartPoduct,
    this.code,
    this.couponDiscount,
    this.shippingAmount,
    this.subtotal,
    this.taxAmount,
    this.discountAmount,
    this.subtotalAmount,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.totalAmount,
    this.couponCode,
  });

  Cart.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    if (json['products'] != null) {
      cartPoduct = <CartProduct>[];
      json['products'].forEach((v) {
        cartPoduct!.add(CartProduct.fromJson(v));
      });
    }
    code = json['code'];
    couponDiscount = json['couponDiscount'];
    shippingAmount = json['shippingAmount'];
    subtotal = json['subtotal'];
    taxAmount = json['taxAmount'];
    discountAmount = json['discountAmount'];
    subtotalAmount = json['subtotalAmount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    totalAmount = json['totalAmount'];
    couponCode = json['couponCode'];
  }
}

class CartProduct {
  CartProductDetails? cartProductDetails;
  int? price;
  int? quantity;
  String? sId;
  String? productId;

  CartProduct({this.cartProductDetails, this.price, this.quantity, this.sId});

  CartProduct.fromJson(Map<String, dynamic> json) {
    Type t = json['productId'].runtimeType;
    if (t == String) {
      productId = json['productId'];
    } else {
      cartProductDetails = json['productId'] != null
          ? CartProductDetails.fromJson(json['productId'])
          : null;
    }
    price = json['price'];
    quantity = json['quantity'];
    sId = json['_id'];
  }
}

class CartProductDetails {
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

  CartProductDetails({
    this.sId,
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
    this.type,
  });

  CartProductDetails.fromJson(Map<String, dynamic> json) {
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
}

class CartSummary {
  int? subtotal;
  int? tax;
  String? shipping;
  int? total;

  CartSummary({this.subtotal, this.tax, this.shipping, this.total});

  CartSummary.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal'];
    tax = json['tax'];
    shipping = json['shipping'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subtotal'] = subtotal;
    data['tax'] = tax;
    data['shipping'] = shipping;
    data['total'] = total;
    return data;
  }
}

extension CartProductExtension on CartProduct {
  CartProduct copyWith({int? qty}) {
    return CartProduct(
      cartProductDetails: cartProductDetails,
      price: price,
      quantity: qty,
      sId: sId,
    );
  }
}
