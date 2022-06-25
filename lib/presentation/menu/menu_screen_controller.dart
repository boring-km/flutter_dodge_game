import 'package:get/get.dart';

class MenuScreenController extends GetxController {
  Future? Function() get startGame => () => Get.toNamed('/game');
}
