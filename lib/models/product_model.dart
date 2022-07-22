import 'dart:convert';

class ProductResponse {
  int? status;
  List<ProductData>? data;

  ProductResponse({this.status, this.data});

  ProductResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductData extends JsonEncoder{
  String? productName;
  String? productDescription;
  String? productPrice;
  String? productModel;
  String? productImage;
  dynamic productId;
  int? categoryId = -1;
  int? productCount = 0;

  ProductData(
      {this.productName,
        this.productDescription,
        this.productPrice,
        this.productModel,
        this.productImage,
        this.productId,
        this.categoryId,
        this.productCount,
      });

  ProductData.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    productDescription = json['product_description'];
    productPrice = json['product_price'];
    productModel = json['product_model'];
    productImage = json['product_image'];
    productId = json['product_id'];
    categoryId = json['category_id'];
    productCount = json['product_count']??productCount;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_name'] = productName;
    data['product_description'] = productDescription;
    data['product_price'] = productPrice;
    data['product_model'] = productModel;
    data['product_image'] = productImage;
    data['product_id'] = productId;
    data['category_id'] = categoryId;
    data['product_count'] = productCount;
    return data;
  }
}
