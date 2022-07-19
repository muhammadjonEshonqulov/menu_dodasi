class CategoryResponse {
  int? status;
  List<CategoryData>? data;

  CategoryResponse({this.status, this.data});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['data'] = this.data?.map((v) => v.toJson()).toList();
    return data;
  }
}

class CategoryData {
  int? categoryId;
  String? categoryName;
  String? categoryPhoto;
  int? categoryCount = 0;


  CategoryData({this.categoryId, this.categoryName, this.categoryPhoto});

  CategoryData.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categoryPhoto = json['category_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['category_photo'] = categoryPhoto;
    return data;
  }
}
