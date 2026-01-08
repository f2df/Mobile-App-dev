import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:mcsofttech/ui/module/meridukaan/internal_page/total_training_attanded.dart';
import 'package:mcsofttech/ui/module/orders/customer_order_list_page.dart';
import 'package:mcsofttech/ui/module/orders/order_details_page.dart';
import 'package:mcsofttech/ui/module/orders/vendor_order_list_page.dart';
import '../../ui/module/enquiry/enquiry_screen.dart';
import '../../ui/module/meridukaan/internal_page/boost_your_product.dart';
import '../../ui/module/meridukaan/internal_page/total_visiter.dart';

class MeriDukaanRoutes {
  MeriDukaanRoutes._();

  static List<GetPage> get routes => [
        GetPage(name: TotalVisitor.routeName, page: () => TotalVisitor()),
        GetPage(name: TotalTraining.routeName, page: () => TotalTraining()),
        GetPage(
            name: BoostYourProduct.routeName, page: () => BoostYourProduct()),
        GetPage(name: EnquiryScreen.routeName, page: () => EnquiryScreen()),
        GetPage(
            name: VendorOrderListPage.routeName,
            page: () => VendorOrderListPage()),
        GetPage(
            name: CustomerOrderListpage.routeName,
            page: () => CustomerOrderListpage()),
        GetPage(
          name: OrderDetailsPage.routeName,
          page: () => OrderDetailsPage(),
        )
      ];
}
