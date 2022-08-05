import 'package:get/get.dart';

class GameScreenController extends GetxController {
  bool isLoaded = false;

  void playerCallback() {
    isLoaded = true;
    update();
  }

  void healthChangeCallback() {
    update();
  }
}
