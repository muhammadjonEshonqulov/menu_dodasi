import 'package:menu_dodasi/models/product_model.dart';

class OrderBody {
  List<OrderData> orders;

  OrderBody(this.orders);
}

class OrderData {
  int category_id;
  List<ProductData> category_products;

  OrderData(this.category_id, this.category_products);

}