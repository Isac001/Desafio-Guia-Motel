import 'package:desafio_guia_motel/list_motel_module/controllers/motel_service_controller.dart';
import 'package:desafio_guia_motel/list_motel_module/services/motel_service.dart';
import 'package:get/get.dart';

class InitializerControllers {

  InitializerControllers() {
    Get.lazyPut(() => MotelServiceController(motelService: MotelService()));
  }
  
}
