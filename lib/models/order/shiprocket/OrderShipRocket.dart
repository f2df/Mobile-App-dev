import 'ShiprocketResponses.dart';

class OrderShipRocket {
  OrderShipRocket({
    required this.amount,
    required this.shiprocketResponses,
    required this.merchantOrderId,
    required this.status,});

  OrderShipRocket.fromJson(dynamic json) {
    amount = json['amount'];
    if (json['shiprocketResponses'] != null) {
      shiprocketResponses = [];
      json['shiprocketResponses'].forEach((v) {
        shiprocketResponses.add(ShiprocketResponses.fromJson(v));
      });
    }
    merchantOrderId = json['merchantOrderId'];
    status = json['status'];
  }
  double amount=0.0;
  List<ShiprocketResponses> shiprocketResponses=[];
  String merchantOrderId="";
  String status="";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    if (shiprocketResponses != null) {
      map['shiprocketResponses'] = shiprocketResponses.map((v) => v.toJson()).toList();
    }
    map['merchantOrderId'] = merchantOrderId;
    map['status'] = status;
    return map;
  }

}