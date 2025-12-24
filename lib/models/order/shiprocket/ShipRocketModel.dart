

import 'OrderShipRocket.dart';

class SHipRocketResModel {
  OrderShipRocket? orderShipRocketData;
  String message;
  bool status;

  SHipRocketResModel({ this.orderShipRocketData, required this.message, required this.status});

  factory SHipRocketResModel.fromJson(Map<String, dynamic> json) {
    return SHipRocketResModel(
      orderShipRocketData: json['data'] != null ? OrderShipRocket.fromJson(json['data']) : null,
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (orderShipRocketData != null) {
      data['data'] = orderShipRocketData?.toJson();
    }
    return data;
  }
}
