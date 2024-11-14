import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:superfoods/app/helpers/theme/theme_customizer.dart';

abstract class MyController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // Listen to theme changes
    ThemeCustomizer.addListener((old, newVal) {
      if (old.theme != newVal.theme ||
          (old.currentLanguage.languageName !=
              newVal.currentLanguage.languageName)) {
        update();
      }
    });
  }

  // // Mandatory
  // @override
  // void onDetached() {
  //   print('MyController - onDetached called');
  // }

  // // Mandatory
  // @override
  // void onInactive() {
  //   print('MyController - onInative called');
  // }

  // // Mandatory
  // @override
  // void onPaused() {
  //   print('MyController - onPaused called');
  // }

  // // Mandatory
  // @override
  // void onResumed() {
  //   print('MyController - onResumed called');
  // }

  // // Mandatory
  // @override
  // void onHidden() {
  //   print('MyController - onHidden called');
  // }
}
