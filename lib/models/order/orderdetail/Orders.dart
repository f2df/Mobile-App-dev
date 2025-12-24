import 'User.dart';
import 'OrderItems.dart';

class Orders {
  Orders({
      required this.orderId,
      required this.user,
      this.address, 
      required this.orderDate,
      required this.orderItems,
      required this.orderStatus,
      required this.orderUuid,
      required this.totalAmount,
      required this.merchantOrderId,});

  Orders.fromJson(dynamic json) {
    orderId = json['orderId']??0;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    address = json['address'];
    orderDate = json['orderDate'];
    if (json['orderItems'] != null) {
      orderItems = [];
      json['orderItems'].forEach((v) {
        orderItems.add(OrderItems.fromJson(v));
      });
    }
    orderStatus = json['orderStatus'];
    orderUuid = json['orderUuid'];
    totalAmount = json['totalAmount'];
    merchantOrderId = json['merchantOrderId'];
  }
  int orderId=0;
  User? user;
  dynamic address;
  String orderDate="";
  List<OrderItems?> orderItems=[];
  String orderStatus="";
  String orderUuid="";
  double totalAmount=0.0;
  String merchantOrderId="";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderId'] = orderId;

    map['address'] = address;
    map['orderDate'] = orderDate;
    if (orderItems != null && orderItems.isNotEmpty) {
      map['orderItems'] = orderItems.map((v) => v?.toJson()).toList();
    }
    map['orderStatus'] = orderStatus;
    map['orderUuid'] = orderUuid;
    map['totalAmount'] = totalAmount;
    map['merchantOrderId'] = merchantOrderId;
    return map;
  }

}