import 'package:get/get.dart';
import '../../../data/models/supplier_model.dart';

class SupplierController extends GetxController {
  late Supplier supplier;

  @override
  void onInit() {
    super.onInit();
    supplier = Get.arguments as Supplier;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
