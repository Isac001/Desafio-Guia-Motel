import 'package:dio/dio.dart';
import 'dart:convert';
import '../models/guia_motel_models.dart';

class MotelService {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  /// Método para buscar os motéis a partir da API online
  Future<List<GuiaMoteisModel>> fetchGuiaMoteis() async {
    try {
      final response = await _dio.get('https://www.jsonkeeper.com/b/1IXK');

      if (response.statusCode == 200) {
        dynamic data = response.data;

        // Se a resposta for String, precisamos decodificá-la
        if (data is String) {
          try {
            data = jsonDecode(data);
          } catch (e) {
            return Future.error("Erro: Resposta da API não é um JSON válido.");
          }
        }

        // Verifica se o JSON tem a estrutura esperada
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
