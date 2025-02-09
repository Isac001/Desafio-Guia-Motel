import 'package:dio/dio.dart';
import 'dart:convert';
import '../models/guia_motel_models.dart';

class MotelService {
  final Dio dio; // Agora é um atributo público

  // Construtor atualizado para permitir injeção de um Dio externo
  MotelService({Dio? dio})
      : dio = dio ??
            Dio(BaseOptions(
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ));

  /// Método para buscar os motéis a partir da API online
  Future<List<GuiaMoteisModel>> fetchGuiaMoteis() async {
    try {
      final response = await dio.get('https://www.jsonkeeper.com/b/1IXK');

      if (response.statusCode == 200) {
        dynamic data = response.data;

        if (data is String) {
          try {
            data = jsonDecode(data);
          } catch (e) {
            return Future.error("Erro: Resposta da API não é um JSON válido.");
          }
        }

        if (data["sucesso"] == true && data["data"]["moteis"] is List) {
          return (data["data"]["moteis"] as List)
              .map((json) => GuiaMoteisModel.fromJson(json))
              .toList();
        } else {
          return Future.error("Erro: Estrutura do JSON inesperada.");
        }
      } else {
        return Future.error("Erro ${response.statusCode}: API retornou um erro.");
      }
    } on DioException catch (error) {
      return Future.error("Erro de Rede: ${error.type} - ${error.message}");
    }
  }
}
