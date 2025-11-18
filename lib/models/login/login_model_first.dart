import 'LoginData.dart';

class LoginFirstModel {
  LoginData? loginData;
  String message;
  int status;

  LoginFirstModel({this.loginData, required this.message, required this.status});

  factory LoginFirstModel.fromJson(Map<String, dynamic> json) {
    return LoginFirstModel(
      loginData: json['data'] != null ? LoginData.fromJson(json['data']) : null,
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (loginData != null) {
      data['data'] = loginData?.toJson();
    }
    return data;
  }
}
