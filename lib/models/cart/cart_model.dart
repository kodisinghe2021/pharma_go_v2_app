class CartModel {
  String date;
  String time;
  String totalPrice;
  CartModel({
    required this.time,
    required this.date,
    required this.totalPrice,
  });
}

class CartItemModel {
  String medicineID;
  String itemPrice;
  String quantity;

  CartItemModel({
    required this.medicineID,
    required this.itemPrice,
    required this.quantity,
  });
}

class CartModelToJson {
  Map<String, dynamic> toJson(CartModel model) {
    Map<String, dynamic> map = {
      'date':model.date,
      'time':model.time,
      'totalPrice':model.totalPrice,
    };
    return map;
  }
}

class CartItemModelToJson {
  Map<String, dynamic> toJson(CartItemModel model) {
    Map<String, dynamic> map = {
      'medicineID':model.medicineID,
      'itemPrice':model.itemPrice,
      'quantity':model.quantity,
    };
    return map;
  }
}

