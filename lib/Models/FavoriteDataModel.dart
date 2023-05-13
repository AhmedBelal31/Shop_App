class FavoriteModel {
  bool? status;

  String? message;

  FavoriteDataModel? data;

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = FavoriteDataModel.fromJson(json['data']);
  }
}

class FavoriteDataModel {
  int? currentPage;

  List<FavoriteDataItemModel> data = [];

  FavoriteDataModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(FavoriteDataItemModel.fromJson(element));
    });
  }
}

class FavoriteDataItemModel {
  int? id;

  ProductDataModel? favoriteProductDataModel;

  FavoriteDataItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    favoriteProductDataModel = ProductDataModel.fromJson(json['product']);
  }
}

class ProductDataModel {
  int? id;

  dynamic price;

  dynamic oldPrice;

  dynamic discount;

  String? image;

  String? name;

  String? description;

  ProductDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
