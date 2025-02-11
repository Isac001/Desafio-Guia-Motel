import 'package:desafio_guia_motel/list_motel_module/providers/motel_provider.dart';
import 'package:desafio_guia_motel/list_motel_module/services/motel_service.dart';
import 'package:desafio_guia_motel/list_motel_module/models/guia_motel_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'motel_provider_test.mocks.dart';

@GenerateMocks([MotelService])
void main() {
  late MockMotelService mockMotelService;
  late MotelProvider motelProvider;

  setUp(() {
    mockMotelService = MockMotelService();
    motelProvider = MotelProvider(mockMotelService);
  });

  group('MotelProvider - lazyLoad', () {
    test('Deve carregar uma lista de motéis e adicionar à paginação', () async {
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

      when(mockMotelService.fetchGuiaMoteis())
          .thenAnswer((_) async => mockMoteis);

      await motelProvider.lazyLoad(0);

      expect(motelProvider.motels.length, 1);
      expect(motelProvider.motels.first.fantasia, "Motel Teste");
      expect(motelProvider.pagingController.itemList?.length, 1);
    });

    test('Deve lidar com erro de API corretamente', () async {
      when(mockMotelService.fetchGuiaMoteis())
          .thenThrow(Exception("Erro na API"));

      await motelProvider.lazyLoad(0);

      expect(motelProvider.errorMessage.isNotEmpty, true);
      expect(motelProvider.pagingController.error, isA<Exception>());
    });
  });

  group('MotelProvider - refreshList', () {
    test('Deve limpar a lista e reiniciar a paginação', () async {
      motelProvider.motels.add(MotelGuideModel.MotelGuideModel(
        fantasia: "Motel Temporário",
        logo: "logo_url",
        bairro: "Sul",
        distancia: 2.0,
        qtdFavoritos: 15,
        suites: [],
      ));

      await motelProvider.refreshList();

      expect(motelProvider.motels, isEmpty);
      expect(motelProvider.pagingController.itemList, isNull);
    });
  });
}
