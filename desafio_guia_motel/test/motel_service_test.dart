// Importing necessary packages and modules
import 'package:desafio_guia_motel/list_motel_module/models/guia_motel_models.dart';
import 'package:desafio_guia_motel/list_motel_module/services/motel_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'motel_service_test.mocks.dart';

// Generating a mock class for Dio using Mockito
@GenerateMocks([Dio])
void main() {
  // Variables for the mock Dio client and service instance
  late MockDio mockDio;
  late MotelService motelService;

  // Setup function to initialize the mock Dio client and service before each test
  setUp(() {
    mockDio = MockDio();
    motelService = MotelService(dio: mockDio);
  });

  // Group of tests related to fetching motel data from the API
  group('MotelService - fetchGuiaMoteis', () {
    // Test to verify successful data retrieval when API responds with status 200
    test('Should return a list of GuiaMoteisModel when the response is 200',
        () async {
      // Mock JSON response data
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

      // Creating a mock response with status 200
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        data: jsonEncode(mockJsonResponse),
        statusCode: 200,
      );

      // Defining the behavior of the mock Dio client
      when(mockDio.get(any)).thenAnswer((_) async => response);

      // Calling the function under test
      final result = await motelService.fetchGuiaMoteis();

      // Expecting a list of MotelGuideModel objects
      expect(result, isA<List<MotelGuideModel>>());
      expect(result.length, 1);
      expect(result.first.fantasia, "Motel Teste");
    });

    // Test to verify error handling when API returns a non-200 status
    test('Should return an error when the API responds with a non-200 status',
        () async {
      // Creating a mock response with status 404
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 404,
      );

      // Defining the behavior of the mock Dio client
      when(mockDio.get(any)).thenAnswer((_) async => response);

      // Expecting the function to throw an error when calling fetchGuiaMoteis
      expect(() async => await motelService.fetchGuiaMoteis(),
          throwsA(isA<String>()));
    });

    // Test to verify error handling when API returns an invalid JSON response
    test('Should return an error when receiving an invalid JSON response',
        () async {
      // Creating a mock response with an invalid JSON format
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        data: "Invalid response",
        statusCode: 200,
      );

      // Defining the behavior of the mock Dio client
      when(mockDio.get(any)).thenAnswer((_) async => response);

      // Expecting the function to throw an error due to invalid JSON
      expect(() async => await motelService.fetchGuiaMoteis(),
          throwsA(contains("Erro: Resposta da API não é um JSON válido.")));
    });

    // Test to verify error handling when JSON structure is unexpected
    test('Should return an error when JSON structure is unexpected', () async {
      // Creating a mock response with an incorrect JSON structure
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        data: {"sucesso": true, "data": {}},
        statusCode: 200,
      );

      // Defining the behavior of the mock Dio client
      when(mockDio.get(any)).thenAnswer((_) async => response);

      // Expecting the function to throw an error due to unexpected JSON structure
      expect(() async => await motelService.fetchGuiaMoteis(),
          throwsA(contains("Erro: Estrutura do JSON inesperada.")));
    });

    // Test to verify handling of network errors using DioException
    test('Should return a network error when DioException is thrown', () async {
      // Simulating a DioException for connection timeout
      when(mockDio.get(any)).thenThrow(DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.connectionTimeout,
        message: "Erro de conexão",
      ));

      // Expecting the function to throw a network error
      expect(() async => await motelService.fetchGuiaMoteis(),
          throwsA(contains("Erro de Rede")));
    });
  });
}
