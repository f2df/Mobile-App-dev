import 'AddressItem.dart';

class AddressListModel {
  AddressListModel({
      required this.data,
      required this.message,
      required this.status,});

  AddressListModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(AddressItem.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  List<AddressItem> data=[];
  String message="";
  int status=200;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    map['status'] = status;
    return map;
  }

}