class SearchModel {
  bool? status;

  String? message;

  SearchDataModel? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = SearchDataModel.fromJson(json['data']);
  }
}

class SearchDataModel {
  int? currentPage;

  List<SearchDataItemModel> data = [];

  SearchDataModel.fromJson(Map<String, dynamic> json) {
    // currentPage = json['currentPage'];
    json['data'].forEach((element) {
      data.add((SearchDataItemModel.fromJson(element)));
    });
  }
}

class SearchDataItemModel {
  int? id;

  dynamic price;

  String? image;

  String? name;

  String? description;

  // List<SearchDataItemImagesModel> imagesList = [];

  bool? inFavorites;

  bool? inCart;

  SearchDataItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    // json['images'].forEach((element) {
    //   imagesList.add(SearchDataItemImagesModel.fromJson(element));
    // });
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}

// class SearchDataItemImagesModel {
//   String? images;
//
//   SearchDataItemImagesModel.fromJson(Map<String, dynamic> json) {
//     images = json['images'];
//   }
// }
