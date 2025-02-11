import 'package:desafio_guia_motel/list_motel_module/models/guia_motel_models.dart';
import 'package:desafio_guia_motel/list_motel_module/services/motel_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'motel_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late MotelService motelService;

  setUp(() {
    mockDio = MockDio();
    motelService = MotelService(dio: mockDio);
  });

  group('MotelService - fetchGuiaMoteis', () {
    test('Deve retornar uma lista de GuiaMoteisModel quando a resposta for 200',
        () async {
      final mockJsonResponse = {
        "sucesso": true,
        "data": {
          "moteis": [
            {
              "fantasia": "Motel Teste",
              "logo": "logo_url",
              "bairro": "Centro",
              "distancia": 1.2,
              "qtdFavoritos": 10,
              "suites": []
            }
          ]
        }
      };

      final response = Response(
        requestOptions: RequestOptions(path: ''),
        data: jsonEncode(mockJsonResponse),
        statusCode: 200,
      );

      when(mockDio.get(any)).thenAnswer((_) async => response);

      final result = await motelService.fetchGuiaMoteis();

      expect(result, isA<List<MotelGuideModel>>());
      expect(result.length, 1);
      expect(result.first.fantasia, "Motel Teste");
    });

    test('Deve retornar erro quando a API retorna um status diferente de 200',
        () async {
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 404,
      );

      when(mockDio.get(any)).thenAnswer((_) async => response);

      expect(() async => await motelService.fetchGuiaMoteis(),
          throwsA(isA<String>()));
    });

    test('Deve retornar erro ao receber um JSON inválido', () async {
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        data: "Resposta inválida",
        statusCode: 200,
      );

      when(mockDio.get(any)).thenAnswer((_) async => response);

      expect(() async => await motelService.fetchGuiaMoteis(),
          throwsA(contains("Erro: Resposta da API não é um JSON válido.")));
    });

    test('Deve retornar erro quando a estrutura do JSON é inesperada',
        () async {
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        data: {"sucesso": true, "data": {}},
        statusCode: 200,
      );

      when(mockDio.get(any)).thenAnswer((_) async => response);

      expect(() async => await motelService.fetchGuiaMoteis(),
          throwsA(contains("Erro: Estrutura do JSON inesperada.")));
    });

    test('Deve retornar erro de rede ao lançar DioException', () async {
      when(mockDio.get(any)).thenThrow(DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.connectionTimeout,
        message: "Erro de conexão",
      ));

      expect(() async => await motelService.fetchGuiaMoteis(),
          throwsA(contains("Erro de Rede")));
    });
  });
}
