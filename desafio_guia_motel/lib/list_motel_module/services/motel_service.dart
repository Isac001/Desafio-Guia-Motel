import 'package:dio/dio.dart';
import 'dart:convert';
import '../models/guia_motel_models.dart';

/// Service responsible for fetching motel data from an online API.
class MotelService {
  /// Public attribute for making HTTP requests.
  final Dio dio;

  /// Constructor that allows dependency injection of an external Dio instance.
  /// If no instance is provided, a default configuration is used.
  MotelService({Dio? dio})
      : dio = dio ??
            Dio(BaseOptions(
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ));

  /// Fetches the list of motels from the online API.
  Future<List<MotelGuideModel>> fetchGuiaMoteis() async {
    try {
      /// Sends a GET request to fetch motel data.
      final response = await dio.get('https://www.jsonkeeper.com/b/1IXK');

      /// Checks if the response status is successful.
      if (response.statusCode == 200) {
        dynamic data = response.data;

        /// If the response is a string, try to parse it as JSON.
        if (data is String) {
          try {
            data = jsonDecode(data);
          } catch (e) {
            return Future.error("Erro: Resposta da API não é um JSON válido.");
          }
        }

        /// Verifies if the JSON structure is correct and contains motel data.
        if (data["sucesso"] == true && data["data"]["moteis"] is List) {
          return (data["data"]["moteis"] as List)
              .map((json) => MotelGuideModel.fromJson(json))
              .toList();
        } else {
          return Future.error("Erro: Estrutura do JSON inesperada.");
        }
      } else {
        /// Returns an error if the API responds with an unsuccessful status code.
        return Future.error(
            "Erro ${response.statusCode}: API retornou um erro.");
      }
    } on DioException catch (error) {
      /// Catches network-related errors and returns an appropriate message.
      return Future.error("Erro de Rede: ${error.type} - ${error.message}");
    }
  }
}
