class CategoryModel {
  bool? status;

  CategoryDataModel? data;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoryDataModel.fromJson(json['data']);
  }
}

class CategoryDataModel {
  int? currentPage;

  List<CategoryItemDataModel> data = [];

  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach(
        (element) => {data.add(CategoryItemDataModel.fromJson(element))});
  }
}

class CategoryItemDataModel {
  int? id;

  String? name;

  String? image;

  CategoryItemDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
