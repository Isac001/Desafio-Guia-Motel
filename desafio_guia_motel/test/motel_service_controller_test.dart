import 'package:desafio_guia_motel/list_motel_module/controllers/motel_service_controller.dart';
import 'package:desafio_guia_motel/list_motel_module/models/guia_motel_models.dart';
import 'package:desafio_guia_motel/list_motel_module/services/motel_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'motel_service_controller_test.mocks.dart';

@GenerateMocks([MotelService])
void main() {
  late MockMotelService mockMotelService;
  late MotelServiceController controller;

  setUp(() {
    mockMotelService = MockMotelService();
    controller = MotelServiceController(motelService: mockMotelService);
  });

  group('MotelServiceController - lazyLoad', () {
    test('Deve carregar uma lista de motéis e adicionar à paginação', () async {
      final mockMoteis = [
        GuiaMoteisModel.MotelGuideModel(
          fantasia: "Motel Teste",
          logo: "logo_url",
          bairro: "Centro",
          distancia: 1.2,
          qtdFavoritos: 10,
          suites: [],
        ),
      ];

      when(mockMotelService.fetchGuiaMoteis())
          .thenAnswer((_) async => mockMoteis);

      await controller.lazyLoad(0);

      expect(controller.moteis.length, 1);
      expect(controller.moteis.first.fantasia, "Motel Teste");
      expect(controller.pagingController.itemList?.length, 1);
    });

    test('Deve iniciar a paginação corretamente', () async {
      controller.onInit();

      controller.pagingController.notifyPageRequestListeners(0);

      verify(mockMotelService.fetchGuiaMoteis()).called(1);
    });

    test('Deve lidar com erros de requisição corretamente', () async {
      when(mockMotelService.fetchGuiaMoteis())
          .thenThrow(Exception("Erro na API"));

      await controller.lazyLoad(0);

      expect(controller.pagingController.error, isA<Exception>());
    });
  });

  group('MotelServiceController - refreshList', () {
    test('Deve limpar a lista e reiniciar a paginação', () async {
      controller.moteis.addAll([
        GuiaMoteisModel.MotelGuideModel(
          fantasia: "Motel Teste",
          logo: "logo_url",
          bairro: "Centro",
          distancia: 1.2,
          qtdFavoritos: 10,
          suites: [],
        ),
      ]);

      await controller.refreshList();

      expect(controller.moteis, isEmpty);
      expect(controller.pagingController.itemList, isNull);
    });
  });

  group('MotelServiceController - onInit', () {
    test('Deve iniciar corretamente e adicionar o listener de paginação', () {
      controller.onInit();
      controller.pagingController.notifyPageRequestListeners(0);

      verify(mockMotelService.fetchGuiaMoteis()).called(1);
    });
  });
}
