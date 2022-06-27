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

class ProductData {
  String? productName;
  String? productDescription;
  String? productPrice;
  String? productModel;
  String? productImage;
  int? productId;

  ProductData(
      {this.productName,
        this.productDescription,
        this.productPrice,
        this.productModel,
        this.productImage,
        this.productId});

  ProductData.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    productDescription = json['product_description'];
    productPrice = json['product_price'];
    productModel = json['product_model'];
    productImage = json['product_image'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['product_description'] = this.productDescription;
    data['product_price'] = this.productPrice;
    data['product_model'] = this.productModel;
    data['product_image'] = this.productImage;
    data['product_id'] = this.productId;
    return data;
  }
}
