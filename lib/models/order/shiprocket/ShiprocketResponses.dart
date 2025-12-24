class ShiprocketResponses {
  ShiprocketResponses({
      required this.orderId,
    required this.channelOrderId,
    required this.shipmentId,
    required this.status,
    required this.statusCode,
    required this.onboardingCompletedNow,
    required this.awbCode,
    required this.courierCompanyId,
    required this.courierName,
    required this.newChannel,});

  ShiprocketResponses.fromJson(dynamic json) {
    orderId = json['order_id'];
    channelOrderId = json['channel_order_id'];
    shipmentId = json['shipment_id'];
    status = json['status'];
    courierName = json['courier_name'];
  }
  int orderId=0;
  String channelOrderId="";
  int shipmentId=0;
  String status="";
  int statusCode=200;
  int onboardingCompletedNow=0;
  String awbCode="";
  int courierCompanyId=0;
  String courierName="";
  bool newChannel=false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = orderId;
    map['channel_order_id'] = channelOrderId;
    map['shipment_id'] = shipmentId;
    map['status'] = status;
    map['status_code'] = statusCode;
    map['onboarding_completed_now'] = onboardingCompletedNow;
    map['awb_code'] = awbCode;
    map['courier_company_id'] = courierCompanyId;
    map['courier_name'] = courierName;
    map['new_channel'] = newChannel;
    return map;
  }

}