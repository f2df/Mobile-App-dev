class Data {
  Data({
      required this.serviceable,});

  Data.fromJson(dynamic json) {
    serviceable = json['serviceable'];
  }
  bool serviceable=false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['serviceable'] = serviceable;
    return map;
  }

}