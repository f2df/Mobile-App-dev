class PhonePayResponse {
  PhonePayResponse({
      required this.orderId,
      required this.state,
      required this.expireAt,
      required this.token,});

  PhonePayResponse.fromJson(dynamic json) {
    orderId = json['orderId']??"";
    state = json['state']??"";
    expireAt = json['expireAt']??0;
    token = json['token']??"";
  }
  String orderId="";
  String state="";
  int expireAt=0;
  String token="";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderId'] = orderId;
    map['state'] = state;
    map['expireAt'] = expireAt;
    map['token'] = token;
    return map;
  }

}