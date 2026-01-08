import 'package:get/get.dart';
import 'package:mcsofttech/controllers/cart/cart_controller.dart';

import 'package:mcsofttech/data/preferences/shared_preferences.dart';
import 'package:mcsofttech/utils/common_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/network/dio_client.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../data/preferences/shared_preferences.dart';
import '../../notifire/kart_notifire.dart';

class InitialBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    try {
      Get.put<AppPreferences>(
          AppPreferences(
              sharedPreferences: await SharedPreferences.getInstance()),
          permanent: true);
      Get.put<DioClient>(DioClient(), permanent: true);
      Get.put<SharedConfig>(SharedConfig(), permanent: true);
      Get.put<NotificationNotifer>(NotificationNotifer(), permanent: true);
      Get.put<Common>(Common(), permanent: true);
      Get.put(CartController());
    } catch (e) {
      print("Error in InitialBindings");
    }
  }
}
