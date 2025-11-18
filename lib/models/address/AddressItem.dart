class AddressItem {
  AddressItem({
      required this.id,
      required this.name,
      required this.mobile,
      required this.houseNo,
      required this.street,
      required this.area,
    required this.landmark,
    required this.state,
    required this.city,
    required this.country,
    required this.pincode,
    required this.userId,
    required this.type,
    required this.selected,});

  AddressItem.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    houseNo = json['houseNo'];
    street = json['street'];
    area = json['area'];
    landmark = json['landmark'];
    state = json['state'];
    city = json['city'];
    country = json['country'];
    pincode = json['pincode'];
    userId = json['userId'];
    type = json['type'];
    selected = json['selected'];
  }
  int id=0;
  String name="";
  String mobile="";
  String houseNo="";
  String street="";
  String area="";
  String landmark="";
  String state="";
  String city="";
  String country="";
  String pincode="";
  int userId=0;
  String type="";
  bool selected=false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['mobile'] = mobile;
    map['houseNo'] = houseNo;
    map['street'] = street;
    map['area'] = area;
    map['landmark'] = landmark;
    map['state'] = state;
    map['city'] = city;
    map['country'] = country;
    map['pincode'] = pincode;
    map['userId'] = userId;
    map['type'] = type;
    map['selected'] = selected;
    return map;
  }

}