class OrderItems {
  OrderItems({
      required this.orderItemId,
      required this.productId,
      required this.quantity,
      required this.subtotal,
      required this.productUserId,
      required this.orderItemUuid,
      required this.orderDate,
      required this.orderUpdatedDate,
      required this.shipRocketOrderId,
      required this.shipRocketShipmentId,
      required this.shipRocketAwbCode,
      required this.assignAwbResponse,
      required this.generatePickupResponse,
      required this.pickupLocationId,
      required this.shipRocketStatus,
      required this.shipRocketStatusCode,
      required this.shipRocketPickupStatus,
      required this.shipRocketPickupToken,
      required this.shipRocketPickupScheduledDate,
      required this.shipRocketPickupConfirmationMsg,});

  OrderItems.fromJson(dynamic json) {
    orderItemId = json['orderItemId']??0;
    productId = json['productId']??0;
    quantity = json['quantity']??0;
    subtotal = json['subtotal']??0.0;
    productUserId = json['productUserId']??0;
    orderItemUuid = json['orderItemUuid']??"";
    orderDate = json['orderDate']??"";
    orderUpdatedDate = json['orderUpdatedDate']??"";
    shipRocketOrderId = json['shipRocketOrderId'];
    shipRocketShipmentId = json['shipRocketShipmentId'];
    shipRocketAwbCode = json['shipRocketAwbCode'];
    assignAwbResponse = json['assignAwbResponse'];
    generatePickupResponse = json['generatePickupResponse'];
    pickupLocationId = json['pickupLocationId']??"";
    shipRocketStatus = json['shipRocketStatus'];
    shipRocketStatusCode = json['shipRocketStatusCode'];
    shipRocketPickupStatus = json['shipRocketPickupStatus'];
    shipRocketPickupToken = json['shipRocketPickupToken'];
    shipRocketPickupScheduledDate = json['shipRocketPickupScheduledDate'];
    shipRocketPickupConfirmationMsg = json['shipRocketPickupConfirmationMsg'];
  }
  int orderItemId=0;
  int productId=0;
  int quantity=0;
  double subtotal=0.0;
  int productUserId=0;
  String orderItemUuid="";
  String orderDate="";
  String orderUpdatedDate="";
  dynamic shipRocketOrderId=0;
  dynamic shipRocketShipmentId=0;
  dynamic shipRocketAwbCode;
  dynamic assignAwbResponse;
  dynamic generatePickupResponse;
  String pickupLocationId="";
  dynamic shipRocketStatus;
  dynamic shipRocketStatusCode;
  dynamic shipRocketPickupStatus;
  dynamic shipRocketPickupToken;
  dynamic shipRocketPickupScheduledDate;
  dynamic shipRocketPickupConfirmationMsg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderItemId'] = orderItemId;
    map['productId'] = productId;
    map['quantity'] = quantity;
    map['subtotal'] = subtotal;
    map['productUserId'] = productUserId;
    map['orderItemUuid'] = orderItemUuid;
    map['orderDate'] = orderDate;
    map['orderUpdatedDate'] = orderUpdatedDate;
    map['shipRocketOrderId'] = shipRocketOrderId;
    map['shipRocketShipmentId'] = shipRocketShipmentId;
    map['shipRocketAwbCode'] = shipRocketAwbCode;
    map['assignAwbResponse'] = assignAwbResponse;
    map['generatePickupResponse'] = generatePickupResponse;
    map['pickupLocationId'] = pickupLocationId??"";
    map['shipRocketStatus'] = shipRocketStatus??"";
    map['shipRocketStatusCode'] = shipRocketStatusCode??"";
    map['shipRocketPickupStatus'] = shipRocketPickupStatus??"";
    map['shipRocketPickupToken'] = shipRocketPickupToken??"";
    map['shipRocketPickupScheduledDate'] = shipRocketPickupScheduledDate??"";
    map['shipRocketPickupConfirmationMsg'] = shipRocketPickupConfirmationMsg??"";
    return map;
  }

}