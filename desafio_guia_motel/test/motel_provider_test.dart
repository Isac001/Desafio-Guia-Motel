// Importing necessary packages and modules
import 'package:desafio_guia_motel/list_motel_module/providers/motel_provider.dart';
import 'package:desafio_guia_motel/list_motel_module/services/motel_service.dart';
import 'package:desafio_guia_motel/list_motel_module/models/guia_motel_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'motel_provider_test.mocks.dart';

// Generating a mock class for MotelService using Mockito
@GenerateMocks([MotelService])
void main() {
  // Variables for the mock service and provider instance
  late MockMotelService mockMotelService;
  late MotelProvider motelProvider;

  // Setup function to initialize the mock service and provider before each test
  setUp(() {
    mockMotelService = MockMotelService();
    motelProvider = MotelProvider(mockMotelService);
  });

  // Group of tests related to lazy loading in MotelProvider
  group('MotelProvider - lazyLoad', () {
    // Test to verify that motels are correctly loaded and added to pagination
    test('Should load a list of motels and add to pagination', () async {
      // Mock motel list for testing
      final mockMoteis = [
        MotelGuideModel.MotelGuideModel(
          fantasia: "Motel Teste",
          logo: "logo_url",
          bairro: "Centro",
          distancia: 1.2,
          qtdFavoritos: 10,
          suites: [],
        ),
      ];

      // Defining behavior for mock service when fetching motels
      when(mockMotelService.fetchGuiaMoteis())
          .thenAnswer((_) async => mockMoteis);

      // Calling lazyLoad function to simulate fetching data
      await motelProvider.lazyLoad(0);

      // Expecting the motel list to have one item
      expect(motelProvider.motels.length, 1);
      expect(motelProvider.motels.first.fantasia, "Motel Teste");

      // Expecting the pagination controller to also contain one item
      expect(motelProvider.pagingController.itemList?.length, 1);
    });

    // Test to verify how the provider handles API errors
    test('Should handle API error correctly', () async {
      // Defining behavior for mock service to throw an exception
      when(mockMotelService.fetchGuiaMoteis())
          .thenThrow(Exception("Erro na API"));

      // Calling lazyLoad function to simulate API failure
      await motelProvider.lazyLoad(0);

      // Expecting an error message to be set
      expect(motelProvider.errorMessage.isNotEmpty, true);

      // Expecting the pagination controller to also contain the error
      expect(motelProvider.pagingController.error, isA<Exception>());
    });
  });

  // Group of tests related to refreshing the motel list
  group('MotelProvider - refreshList', () {
    // Test to verify that refreshList clears the list and resets pagination
    test('Should clear the list and restart pagination', () async {
      // Adding a temporary motel to the list
      motelProvider.motels.add(MotelGuideModel.MotelGuideModel(
        fantasia: "Motel Temporário",
        logo: "logo_url",
        bairro: "Sul",
        distancia: 2.0,
        qtdFavoritos: 15,
        suites: [],
      ));

      // Calling refreshList to reset the list
      await motelProvider.refreshList();

      // Expecting the motel list to be empty
      expect(motelProvider.motels, isEmpty);

      // Expecting the pagination controller to be reset
      expect(motelProvider.pagingController.itemList, isNull);
    });
  });
}
