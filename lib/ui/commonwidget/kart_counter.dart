import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/utils/palette.dart';

class KartCounter extends StatelessWidget {
  const KartCounter({
    Key? key,
    required this.count,
  }) : super(key: key);

  final RxInt count;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 12,
        width: 12,
        decoration:
            BoxDecoration(color: MyColors.transparent, shape: BoxShape.circle),
        child: Center(
            child: Obx(() => Text(
                  count.value.toString(),
                  style:
                      const TextStyle(color: Palette.kColorWhite, fontSize: 10),
                ))));
  }
}
