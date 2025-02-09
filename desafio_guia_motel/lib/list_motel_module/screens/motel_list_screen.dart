import 'package:desafio_guia_motel/components/fields_components/bar_itens_suite_component.dart';
import 'package:desafio_guia_motel/components/fields_components/reservation_list_component.dart';
import 'package:desafio_guia_motel/components/widget_components/custom_toggle_switch_component.dart';
import 'package:desafio_guia_motel/components/widget_components/icon_component.dart';
import 'package:desafio_guia_motel/components/widget_components/text_component.dart';
import 'package:desafio_guia_motel/constants/fontsize_constants.dart';
import 'package:desafio_guia_motel/constants/padding_constants.dart';
import 'package:desafio_guia_motel/list_motel_module/controllers/motel_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../models/guia_motel_models.dart';

class MotelListScreen extends StatefulWidget {
  const MotelListScreen({super.key});

  @override
  State<MotelListScreen> createState() => _MotelListScreenState();
}

class _MotelListScreenState extends State<MotelListScreen> {
  final MotelServiceController _motelServiceController =
      Get.find<MotelServiceController>();

  String selectedZone = 'Zona Norte';

  final List<String> zones = [
    'Zona Norte',
    'Zona Sul',
    'Zona Leste',
    'Zona Oeste',
    'Centro'
  ];

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
      backgroundColor: Colors.red.shade700,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red.shade700,
        toolbarHeight: 120,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const IconWidget(icon: Icons.menu, size: 28),
                  onPressed: () {},
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: CustomToggleSwitch(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const IconWidget(icon: Icons.search, size: 28),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: kPaddingSM),
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
                borderRadius: BorderRadius.circular(kPaddingSM),
                items: zones.map((zone) {
                  return DropdownMenuItem<String>(
                    value: zone,
                    child: TextComponent(
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
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(kPaddingMedium),
            topRight: Radius.circular(kPaddingMedium),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(kPaddingMedium),
          child: PagedListView<int, GuiaMoteisModel>(
            pagingController: _motelServiceController.pagingController,
            builderDelegate: PagedChildBuilderDelegate(
              firstPageErrorIndicatorBuilder: (context) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TextComponent(
                        data: "Erro ao carregar dados.",
                        fontSize: kFontsizeMedium,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _motelServiceController.refreshList();
                          });
                        },
                        child: const TextComponent(
                          data: "Tentar Novamente",
                          fontSize: kFontsizeMedium,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
              noItemsFoundIndicatorBuilder: (context) {
                return const Center(
                  child: TextComponent(
                    data: "Nenhum motel encontrado!",
                    fontSize: kFontsizeMedium,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                );
              },
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
                              TextComponent(
                                data: motel.fantasia,
                                fontSize: kFontsizeMedium,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'Times New Roman',
                              ),
                              TextComponent(
                                data: motel.bairro,
                                fontSize: kFontsizeStandard,
                                color: Colors.grey.shade700,
                              ),
                              TextComponent(
                                data:
                                    "${motel.distancia.toStringAsFixed(2)} km",
                                fontSize: kFontsizeStandard,
                                color: Colors.grey.shade700,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 650,
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
                                            mainAxisSize: MainAxisSize.min,
                                            children: suite.fotos.map((foto) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: kPaddingSmall),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          kPaddingSmall),
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
                                          padding: const EdgeInsets.all(
                                              kPaddingSmall),
                                          child: TextComponent(
                                            data: suite.nome,
                                            fontSize: kFontsizeMedium,
                                            fontWeight: FontWeight.bold,
                                            textAlign: TextAlign.center,
                                            color: Colors.black,
                                            fontFamily: 'Times New Roman',
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
                                      suiteName: suite.nome,
                                    ),
                                  ),
                                  ReservationListComponent(
                                    periods: suite.periodos.map((periodo) {
                                      return {
                                        'tempoFormatado':
                                            periodo.tempoFormatado,
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
      ),
    );
  }
}
