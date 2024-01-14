class IntialCartItemEntity {
  String? sId;
  String? userId;
  List<MinProductDetails>? minProductDetails;
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

  IntialCartItemEntity(
      {this.sId,
      this.userId,
      this.minProductDetails,
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
      this.couponCode});

  IntialCartItemEntity.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    if (json['products'] != null) {
      minProductDetails = <MinProductDetails>[];
      json['products'].forEach((v) {
        minProductDetails!.add(MinProductDetails.fromJson(v));
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

class MinProductDetails {
  String? productId;
  int? price;
  int? quantity;
  String? sId;

  MinProductDetails({this.productId, this.price, this.quantity, this.sId});

  MinProductDetails.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    price = json['price'];
    quantity = json['quantity'] ?? 0;
    sId = json['_id'];
  }
}
