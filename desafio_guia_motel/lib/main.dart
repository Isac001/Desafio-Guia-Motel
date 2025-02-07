import 'package:desafio_guia_motel/list_motel_module/models/guia_motel_models.dart';
import 'package:desafio_guia_motel/list_motel_module/services/motel_service.dart';

void main() async {
  final motelService = MotelService();

  try {
    List<GuiaMoteisModel> moteis = await motelService.fetchGuiaMoteis();
    for (var motel in moteis) {
      print("🏨 Motel: ${motel.fantasia}");
      print("📍 Bairro: ${motel.bairro}");
      print("📏 Distância: ${motel.distancia} km");
      print("💖 Favoritos: ${motel.qtdFavoritos}");
      print("🛏️ Suítes disponíveis: ${motel.suites.length}");
      print("----------------------");
    }
  } catch (e) {
    print("❌ Erro ao buscar motéis: $e");
  }
}
