import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:mcsofttech/ui/module/address/add_address.dart';

import '../../ui/module/address/address_list.dart';

class AddressRoutes {
  AddressRoutes._();

  static List<GetPage> get routes => [
    GetPage(name: AddAddress.routeName, page: () => AddAddress()),
    GetPage(name: AddressList.routeName, page: () => AddressList()),
  ];
}