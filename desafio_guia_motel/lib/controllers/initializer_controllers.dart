import 'package:desafio_guia_motel/list_motel_module/controllers/motel_controller.dart';
import 'package:get/get.dart';

class InitializerControllers {

  InitializerControllers() {
    Get.lazyPut(() => MotelServiceController());
  }
  
}
