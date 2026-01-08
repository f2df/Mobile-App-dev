// To parse this JSON data, do
//
//     final orderListResponse = orderListResponseFromJson(jsonString);

import 'dart:convert';
import 'dart:math';

OrderListResponse orderListResponseFromJson(String str) =>
    OrderListResponse.fromJson(json.decode(str));

String orderListResponseToJson(OrderListResponse data) =>
    json.encode(data.toJson());

class OrderListResponse {
  List<OrderList>? orderList;
  String? message;
  int? status;

  OrderListResponse({
    this.orderList,
    this.message,
    this.status,
  });

  factory OrderListResponse.fromJson(Map<String, dynamic> json) =>
      OrderListResponse(
        orderList: json["data"] == null
            ? []
            : List<OrderList>.from(
                json["data"]!.map((x) => OrderList.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": orderList == null
            ? []
            : List<dynamic>.from(orderList!.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class OrderList {
  String? orderUUid;
  int? totalPrice;
  DeliveryAddress? deliveryAddress;
  List<ItemList>? itemList;
  String? oderDate;

  OrderList({
    this.orderUUid,
    this.totalPrice,
    this.deliveryAddress,
    this.itemList,
    this.oderDate,
  });

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
        orderUUid: json["orderUUid"],
        totalPrice: json["totalPrice"].toInt(),
        deliveryAddress: json["deliveryAddress"] == null
            ? null
            : DeliveryAddress.fromJson(json["deliveryAddress"]),
        itemList: json["itemList"] == null
            ? []
            : List<ItemList>.from(
                json["itemList"]!.map((x) => ItemList.fromJson(x))),
        oderDate: json["oderDate"],
      );

  Map<String, dynamic> toJson() => {
        "orderUUid": orderUUid,
        "totalPrice": totalPrice,
        "deliveryAddress": deliveryAddress?.toJson(),
        "itemList": itemList == null
            ? []
            : List<dynamic>.from(itemList!.map((x) => x.toJson())),
        "oderDate": oderDate,
      };
}

class DeliveryAddress {
  int? id;
  String? name;
  String? mobile;
  String? houseNo;
  String? street;
  String? area;
  String? landmark;
  String? state;
  String? city;
  String? country;
  String? pincode;
  int? userId;
  String? type;
  bool? selected;

  DeliveryAddress({
    this.id,
    this.name,
    this.mobile,
    this.houseNo,
    this.street,
    this.area,
    this.landmark,
    this.state,
    this.city,
    this.country,
    this.pincode,
    this.userId,
    this.type,
    this.selected,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) =>
      DeliveryAddress(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        houseNo: json["houseNo"],
        street: json["street"],
        area: json["area"],
        landmark: json["landmark"],
        state: json["state"],
        city: json["city"],
        country: json["country"],
        pincode: json["pincode"],
        userId: json["userId"],
        type: json["type"],
        selected: json["selected"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "houseNo": houseNo,
        "street": street,
        "area": area,
        "landmark": landmark,
        "state": state,
        "city": city,
        "country": country,
        "pincode": pincode,
        "userId": userId,
        "type": type,
        "selected": selected,
      };
  @override
  String toString() {
    // TODO: implement toString
    return [name, houseNo, street, area, landmark, state, city, country]
            .where((element) => element?.isNotEmpty ?? false)
            .join(", ") +
        ' ' +
        (pincode ?? "") +
        ((mobile?.isNotEmpty ?? false)
            ? ("\n\nMobile Number: ${mobile ?? ""}")
            : "");
  }
}

class ItemList {
  int? productId;
  int? quantity;
  String? productName;
  int? price;
  String? status;
  String? orderUUid;

  ItemList({
    this.productId,
    this.quantity,
    this.productName,
    this.price,
    this.status,
    this.orderUUid,
  });

  factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
        productId: json["productId"],
        quantity: json["quantity"],
        productName: json["productName"],
        price: json["price"].toInt(),
        status: json["status"],
        orderUUid: json["orderUUid"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "quantity": quantity,
        "productName": productName,
        "price": price,
        "status": status,
        "orderUUid": orderUUid,
      };
}
