import 'PickUpList.dart';

class CommonDataResponseModel {
  String message = "";
  List<PickUpList>? data;
  int status;


  CommonDataResponseModel(
      {required this.message,
      required this.status,
      required this.data,});

  factory CommonDataResponseModel.fromJson(Map<String, dynamic> json) {
    return CommonDataResponseModel(
        message: json['message'] ?? "",
        data: json["data"] == null
            ? []
            : List<PickUpList>.from(
            json["data"]!.map((x) => PickUpList.fromJson(x))),
        status: json['status'] ?? 404);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['data'] = data;
    data['status'] = status;
    return data;
  }
}
