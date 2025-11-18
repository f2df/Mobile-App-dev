import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/controllers/base_getx_controller.dart';
import 'package:mcsofttech/data/network/apiservices/login_api_service.dart';
import 'package:mcsofttech/data/preferences/AppPreferences.dart';
import 'package:mcsofttech/models/login/LoginData.dart';
import 'package:mcsofttech/models/login/login_model_first.dart';
import 'package:mcsofttech/ui/module/home/home.dart';
import 'package:mcsofttech/ui/module/login/otp_page.dart';
import 'package:mcsofttech/ui/module/profile/profile_list.dart';
import 'package:mcsofttech/ui/module/profile/profile_page.dart';
import 'package:mcsofttech/utils/analytics.dart';
import '../../data/network/apiservices/splash_api_service.dart';
import '../../utils/common_util.dart';

class LoginController extends BaseController {
  final apiServices = Get.put(LoginApiServices());
  final apiServicesUpdate = Get.put(SplashApiServices());
  final appPreferences = Get.find<AppPreferences>();
  final mobileController = TextEditingController();
  final referralCodeController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final userNameController = TextEditingController();
  final userProfileData = "";
  final type = "mobile";
  final isLoader = false.obs;
  late LoginTokenData loginModel;
  late LoginData loginFirstModel;
  final isUpdateLoader =false.obs;

  void callLoginApi(
      {mobile, loginId, username, email, type, termAndCondition}) async {
    if (type != "gmail" && mobileController.text.isEmpty) {
      Common.showToast("Please enter mobile");
      return;
    }
    if (!termAndCondition) {
      Common.showToast("Please accept term and condition.");
      return;
    }
    showLoader();
    try {
      final response =
          await apiServices.loginApi(mobile, loginId, termAndCondition);
      hideLoader();
      //if (response == null) Common.showToast("Server Error!");
      if (response != null &&
          response.status == 200 &&
          response.loginData != null) {
        loginFirstModel = response.loginData!;
        appPreferences.saveEmail(loginFirstModel.email);
        appPreferences.saveUserName(loginFirstModel.name);
        appPreferences.saveUserId(loginFirstModel.id.toString());
        appPreferences.saveUserImage(loginFirstModel.img);
        appPreferences.saveMobile(mobile ?? "");
        appPreferences.saveLoggedIn(true);
        appPreferences.saveReferralCode(loginFirstModel.reffralCode);
        appPreferences.saveUserExit(loginFirstModel.userExist);
        if (type == "mobile") {
          appPreferences.saveLoggedIn(false);
          OtpPage.start(mobile);
        } else if (!loginFirstModel.userExist) {
          ProfileOptions.start(fromTab: "FromLogin");
        } else {
          // Analytics.logLogin(loginMethod: "mobile");
          //Analytics.logUser(userId: appPreferences.userId, userName: appPreferences.userName);
          Home.start(0);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void callOtpReSendApi({mobile, loginId, username, email, type}) async {
    showLoader();
    try {
      final response = await apiServices.loginApi(
        mobile,
        loginId,
        true,
      );
      hideLoader();
      //if (response == null) Common.showToast("Server Error!");
      if (response != null &&
          response.status == 200 &&
          response.loginData != null) {
        loginFirstModel = response.loginData!;
        appPreferences.saveEmail(loginFirstModel.email);
        appPreferences.saveUserName(loginFirstModel.name);
        appPreferences.saveUserId(loginFirstModel.id.toString());
        appPreferences.saveUserImage(loginFirstModel.img);
        appPreferences.saveMobile(mobile ?? "");
        //appPreferences.saveLoggedIn(true);
        appPreferences.saveReferralCode(loginFirstModel.reffralCode);
        appPreferences.saveUserExit(loginFirstModel.userExist);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void callVerifyOtpApi({mobile, otp}) async {
    if (otp.isEmpty) {
      Common.showToast("Please enter otp");
      return;
    }
    showLoader();
    final response = await apiServices.otpApi(
        mobile: mobile, otp: otp, refferalCode: referralCodeController.text);
    hideLoader();

    if (response == null) Common.showToast("Network Error!");
    if (response != null &&
        response.status == 200 &&
        response.loginData != null) {
      loginModel = response.loginData!;
      appPreferences.saveEmail(loginModel.loginData!.email);
      appPreferences.saveAuthToken(loginModel.token);
      appPreferences.saveUserName(loginModel.loginData!.name);
      appPreferences.saveUserId(loginModel.loginData!.id.toString());
      appPreferences.saveUserImage(loginModel.loginData!.img);
      appPreferences.saveLoggedIn(true);
      if (response.loginData!.loginData!.userExist) {
        Home.start(0);
      } else {
        Home.start(0);
       // ProfileOptions.start(fromTab: "FromLogin");
      }
    }
  }

  bool checkSignUpValidation() {
    if (emailController.text.isEmpty) {
      Common.showToast("Please enter email");
      return false;
    }
    if (userNameController.text.isEmpty) {
      Common.showToast("Please enter user name");
      return false;
    }
    if (mobileController.text.isEmpty) {
      Common.showToast("Please enter mobile");
      return false;
    }
    if (addressController.text.isEmpty) {
      Common.showToast("Please enter address");
      return false;
    }
    return true;
  }
  Future<bool> callForceUpdateApi() async {
    String currentAppVersion = "36";
    isUpdateLoader.value = true;
    await Common.getAppCurrentVersion()
        .then((value) => currentAppVersion = value);
    final response =
    await apiServicesUpdate.forceUpdateApi(appVersion: currentAppVersion);
    isUpdateLoader.value = false;
    //if (response == null) Common.showToast("Something went wrong!");
    if (response as bool) {
      //showAlertDialog();
      return true;
    } else {
      return true;
    }
  }
}
