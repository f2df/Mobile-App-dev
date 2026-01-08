import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/services/navigator.dart';
import 'package:mcsofttech/ui/base/page.dart';
import 'package:mcsofttech/ui/commonwidget/more_card_widget.dart';
import 'package:mcsofttech/ui/module/login/login_page.dart';
import 'package:mcsofttech/ui/module/orders/customer_order_list_page.dart';
import 'package:mcsofttech/ui/module/profile/profile_page.dart';
import '../../../../data/preferences/AppPreferences.dart';

class ProfileOptions extends AppPageWithAppBar {
  static String routeName = "/profileOptions";
  ProfileOptions({Key? key}) : super(key: key);

  static Future<bool?> start<bool>({fromTab}) {
    return navigateTo<bool>(routeName,
        currentPageTitle: "Profile", arguments: {"fromTab": fromTab});
  }

  final appPreferences = Get.find<AppPreferences>();

  @override
  Widget get body {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                profileCard,
                const SizedBox(
                  width: 10,
                ),
                orders
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget get profileCard {
    return InkWell(
      onTap: () {
        if (appPreferences.isLoggedIn) {
          EditProfile.start(fromTab: "FromLogin");
        } else {
          LoginPage.start();
        }
      },
      child: const MoreWidgetCard(
          assetName: "assets/svg/ic_profile_card.png",
          text: "My Profile",
          iconAsset: "assets/svg/icon_profile.png"),
    );
  }

  Widget get orders {
    return InkWell(
      onTap: () {
        CustomerOrderListpage.start("My orders");
      },
      child: const MoreWidgetCard(
          assetName: "assets/svg/ic_mandi_bhav_card.png",
          text: "My Orders",
          iconAsset: "assets/svg/ic_mondi_icon.png"),
    );
  }
}
