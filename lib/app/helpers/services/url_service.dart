import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlService {
  static goToUrl(String url) async {
    await launchUrl(Uri.parse(url));
  }

  static goToPurchase() {
    goToUrl('https://codecanyon.net/item/flatten-flutter-admin-panel/45285824');
  }

  static getCurrentUrl() {
    // var path = Uri.base.path;
    // add get parameters
    // return path.replaceAll('flatten/web/', '');
    // get Get current url
    return Get.currentRoute;
  }
}
