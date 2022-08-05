import 'package:get/get.dart';

class MenuScreenController extends GetxController {
  Future<dynamic>? startGame() => Get.toNamed('/game');

  Future<dynamic>? getScore() => Get.toNamed('/score');
}
