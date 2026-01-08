class NewOrderResponse {
  int? statusCode;
  String? message;
  NewOrder? data;

  NewOrderResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory NewOrderResponse.fromJson(Map<String, dynamic> json) =>
      NewOrderResponse(
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null ? null : NewOrder.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": data?.toJson(),
      };
}

class NewOrder {
  String? orderUuid;
  int? totalPrice;

  NewOrder({
    this.orderUuid,
    this.totalPrice,
  });

  factory NewOrder.fromJson(Map<String, dynamic> json) => NewOrder(
        orderUuid: json["orderUuid"],
        totalPrice: json["totalPrice"].toInt(),
      );

  Map<String, dynamic> toJson() => {
        "orderUuid": orderUuid,
        "totalPrice": totalPrice,
      };
}
