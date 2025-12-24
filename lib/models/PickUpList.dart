class PickUpList {
  PickUpList({
      required this.id,
      required this.state,
      required this.address,
      required this.city,
      required this.pickupPinCode,
      required this.pickupLocation,});

  PickUpList.fromJson(dynamic json) {
    id = json['id']??0;
    state = json['state']??"";
    address = json['address']??"";
    city = json['city']??"";
    pickupPinCode = json['pickup_pin_code']??"";
    pickupLocation = json['pickup_location']??"";
  }
  int id=0;
  String state="";
  String address="";
  String city="";
  String pickupPinCode="";
  String pickupLocation="";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['state'] = state;
    map['address'] = address;
    map['city'] = city;
    map['pickup_pin_code'] = pickupPinCode;
    map['pickup_location'] = pickupLocation;
    return map;
  }

}