class CategoryEntity {
  String? sId;
  String? name;
  String? image;
  String? status;
  int? iV;

  CategoryEntity({this.sId, this.name, this.image, this.status, this.iV});

  CategoryEntity.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['image'] = image;
    data['status'] = status;
    data['__v'] = iV;
    return data;
  }
}
