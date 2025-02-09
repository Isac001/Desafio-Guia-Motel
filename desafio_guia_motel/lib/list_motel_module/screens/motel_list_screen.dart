import 'package:desafio_guia_motel/components/bar_itens_suite_component.dart';
import 'package:desafio_guia_motel/components/custom_toggle_switch_component.dart';
import 'package:desafio_guia_motel/components/icon_component.dart';
import 'package:desafio_guia_motel/components/reservation_value_camp_component.dart';
import 'package:desafio_guia_motel/components/text_component.dart';
import 'package:desafio_guia_motel/constans/fontsize_constants.dart';
import 'package:desafio_guia_motel/constans/paddigns_constans.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../controllers/motel_controller.dart';
import '../models/guia_motel_models.dart';

class MotelListScreen extends StatefulWidget {
  const MotelListScreen({super.key});

  @override
  State<MotelListScreen> createState() => _MotelListScreenState();
}

class _MotelListScreenState extends State<MotelListScreen> {
  final MotelServiceController _motelServiceController =
      Get.find<MotelServiceController>();

  String selectedZone = 'Zona Norte'; // Valor inicial do dropdown

  final List<String> zones = [
    'Zona Norte',
    'Zona Sul',
    'Zona Leste',
    'Zona Oeste',
    'Centro'
  ]; // Lista de zonas de São Paulo

  @override
  void initState() {
    super.initState();
    _motelServiceController.pagingController
        .addPageRequestListener((pageKey) async {
      await _motelServiceController.lazyLoad(pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red.shade700,
        toolbarHeight: 120,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Ícone de menu
                IconButton(
                  icon: const IconWidget(icon: Icons.menu, size: 28),
                  onPressed: () {},
                ),
                // Toggle switch
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: CustomToggleSwitch(),
                  ),
                ),
                // Ícone de pesquisa
                IconButton(
                  icon: const IconWidget(icon: Icons.search, size: 28),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: kPaddingSmall),

            // Dropdown de zonas
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedZone,
                icon: const IconWidget(icon: Icons.arrow_drop_down),
                dropdownColor: Colors.red.shade700,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: kFontsizeStandard,
                  fontWeight: FontWeight.bold,
                ),
                borderRadius: BorderRadius.circular(12),
                items: zones.map((zone) {
                  return DropdownMenuItem<String>(
                    value: zone,
                    child: TextWidget(
                      data: zone,
                      fontSize: kFontsizeStandard,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedZone = newValue!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kPaddingMedium),
        child: PagedListView<int, GuiaMoteisModel>(
          pagingController: _motelServiceController.pagingController,
          builderDelegate: PagedChildBuilderDelegate(
            firstPageErrorIndicatorBuilder: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextWidget(
                    data: "Erro ao carregar dados.",
                    fontSize: kFontsizeMedium,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  ElevatedButton(
                    onPressed: () => _motelServiceController.refreshList(),
                    child: const TextWidget(
                      data: "Tentar Novamente",
                      fontSize: kFontsizeMedium,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            noItemsFoundIndicatorBuilder: (context) => const Center(
              child: TextWidget(
                data: "Nenhum motel encontrado!",
                fontSize: kFontsizeMedium,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            itemBuilder: (context, motel, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: kPaddingSM),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.network(
                            motel.logo,
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: kPaddingSM),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              data: motel.fantasia,
                              fontSize: kFontsizeMedium,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Times New Roman',
                            ),
                            TextWidget(
                              data: motel.bairro,
                              fontSize: kFontsizeStandard,
                              color: Colors.grey.shade700,
                            ),
                            TextWidget(
                              data: "${motel.distancia.toStringAsFixed(2)} km",
                              fontSize: kFontsizeStandard,
                              color: Colors.grey.shade700,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 800,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: motel.suites.length,
                      itemBuilder: (context, suiteIndex) {
                        final suite = motel.suites[suiteIndex];

                        return Padding(
                          padding: const EdgeInsets.only(right: kPaddingSM),
                          child: SizedBox(
                            width: 330,
                            height: 330,
                            child: Column(
                              children: [
                                Card(
                                  elevation: 0,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: suite.fotos.map((foto) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: kPaddingSmall),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  foto,
                                                  height: 240,
                                                  width: 300,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.all(kPaddingSmall),
                                        child: TextWidget(
                                          data: suite.nome,
                                          fontSize: kFontsizeMedium,
                                          fontWeight: FontWeight.bold,
                                          textAlign: TextAlign.center,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: kPaddingSmall - 4),
                                  child: BarItensSuiteComponent(
                                    items: suite.categoriaItens.map((item) {
                                      return {
                                        'icone': item.icone,
                                        'nome': item.nome,
                                      };
                                    }).toList(),
                                    iconSize: 40.0,
                                  ),
                                ),
                                ReservationList(
                                  periods: suite.periodos.map((periodo) {
                                    return {
                                      'tempoFormatado': periodo.tempoFormatado,
                                      'valor': periodo.valor,
                                      'valorTotal': periodo.valorTotal,
                                      'desconto': periodo.desconto,
                                    };
                                  }).toList(),
                                  onReserveTap: (index) {
                                    print(
                                        "Reservar para o período ${suite.periodos[index].tempoFormatado}");
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
