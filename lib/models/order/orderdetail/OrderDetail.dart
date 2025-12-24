import 'Orders.dart';
import 'PhonePayResponse.dart';

class OrderDetail {
  OrderDetail({
      required this.phonepeResponse,
      required this.orders,});

  OrderDetail.fromJson(dynamic json) {
    phonepeResponse = json['PhonepeResponse'] != null ? PhonePayResponse.fromJson(json['PhonepeResponse']) : null;
    if (json['orders'] != null) {
      orders = [];
      json['orders'].forEach((v) {
        orders.add(Orders.fromJson(v));
      });
    }
  }
  PhonePayResponse? phonepeResponse;
  String paymentOrderId="";
  List<Orders> orders=[];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (orders != null) {
      map['orders'] = orders.map((v) => v.toJson()).toList();
    }
    return map;
  }

}