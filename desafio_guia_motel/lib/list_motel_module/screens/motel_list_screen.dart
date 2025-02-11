import 'package:desafio_guia_motel/components/fields_components/bar_itens_suite_component.dart';
import 'package:desafio_guia_motel/components/fields_components/reserve_suite_component.dart';
import 'package:desafio_guia_motel/components/widget_components/custom_switch_component.dart';
import 'package:desafio_guia_motel/components/widget_components/text_component.dart';
import 'package:desafio_guia_motel/constants/fontsize_constants.dart';
import 'package:desafio_guia_motel/constants/padding_constants.dart';
import 'package:desafio_guia_motel/constants/radius_constants.dart';
import 'package:desafio_guia_motel/constants/theme_color.dart';
import 'package:desafio_guia_motel/list_motel_module/providers/motel_provider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import '../models/guia_motel_models.dart';

// Stateful widget representing the Motel List screen
class MotelListScreen extends StatefulWidget {
  const MotelListScreen({super.key});

  @override
  State<MotelListScreen> createState() => _MotelListScreenState();
}

class _MotelListScreenState extends State<MotelListScreen> {
  // Default selected zone
  String selectedZone = 'Zona Norte';

  // List of available zones
  final List<String> zones = [
    'Zona Norte',
    'Zona Sul',
    'Zona Leste',
    'Zona Oeste',
    'Centro'
  ];

  // Inition Fuctions
  @override
  void initState() {
    super.initState();

    // Adding a listener for pagination after the first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final motelProvider = Provider.of<MotelProvider>(context, listen: false);
      motelProvider.pagingController.addPageRequestListener((pageKey) async {
        await motelProvider.lazyLoad(pageKey);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Getting screen dimensions
    final motelProvider = Provider.of<MotelProvider>(context, listen: false);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ThemeColor.primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ThemeColor.primaryColor,
        toolbarHeight: screenHeight * 0.125,
        title: Column(
          children: [
            // Top navigation row with menu, switch, and search
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.menu,
                    size: kFontsizeXLarge,
                    color: ThemeColor.whiteColor,
                  ),
                  onPressed: () {},
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: const CustomSwitchComponent(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search,
                      size: kFontsizeXLarge, color: ThemeColor.whiteColor),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: kPaddingSM),

            // Zone selection dropdown
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedZone,
                icon: const Icon(Icons.arrow_drop_down,
                    color: ThemeColor.whiteColor),
                dropdownColor: ThemeColor.primaryColor,
                style: const TextStyle(
                  color: ThemeColor.whiteColor,
                  fontSize: kFontsizeStandard,
                  fontWeight: FontWeight.bold,
                ),
                borderRadius: BorderRadius.circular(kRadiusMedium),
                items: zones.map((zone) {
                  return DropdownMenuItem<String>(
                    value: zone,
                    child: TextComponent(
                      data: zone,
                      fontSize: kFontsizeStandard,
                      fontWeight: FontWeight.bold,
                      color: ThemeColor.whiteColor,
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

      // Body container with rounded borders and light gray background
      body: Container(
        decoration: BoxDecoration(
          color: ThemeColor.lightGreyColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(kRadiusMedium),
            topRight: Radius.circular(kRadiusMedium),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(kPaddingMedium),

          // Paginated list of moteis
          child: PagedListView<int, MotelGuideModel>(
            pagingController: motelProvider.pagingController,
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
                        color: ThemeColor.secundaryColor,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            motelProvider.refreshList();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeColor.primaryColor,
                        ),
                        child: const TextComponent(
                          data: "Tentar Novamente",
                          fontSize: kFontsizeMedium,
                          fontWeight: FontWeight.bold,
                          color: ThemeColor.whiteColor,
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
                    color: ThemeColor.secundaryColor,
                  ),
                );
              },

              // Building each motel item in the list
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
                              height: screenHeight * 0.1,
                              width: screenHeight * 0.1,
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
                                color: ThemeColor.secundaryColor,
                              ),
                              TextComponent(
                                data: motel.bairro,
                                fontSize: kFontsizeStandard,
                                color: ThemeColor.greyColor,
                              ),
                              TextComponent(
                                data:
                                    "${motel.distancia.toStringAsFixed(2)} km",
                                fontSize: kFontsizeStandard,
                                color: ThemeColor.greyColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // List of available suites
                    SizedBox(
                      height: screenHeight * 0.9,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: motel.suites.length,
                        itemBuilder: (context, suiteIndex) {
                          final suite = motel.suites[suiteIndex];
                          return Padding(
                            padding: const EdgeInsets.only(right: kPaddingSM),
                            child: SizedBox(
                              width: screenWidth * 0.85,
                              child: Column(
                                children: [
                                  Card(
                                    elevation: 0,
                                    color: ThemeColor.whiteColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(kRadiusSmall),
                                      side: const BorderSide(
                                          color: ThemeColor.greyColor,
                                          width: 0.3),
                                    ),
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
                                                          kRadiusSmall),
                                                  child: Image.network(
                                                    foto,
                                                    height: screenHeight * 0.34,
                                                    width: screenWidth * 0.7,
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

                                  // Bar of Items available
                                  BarItensSwitchComponent(
                                    items: suite.categoriaItens.map((item) {
                                      return {
                                        'icone': item.icone,
                                        'nome': item.nome,
                                      };
                                    }).toList(),
                                    iconSize: screenWidth * 0.1,
                                    suiteName: suite.nome,
                                  ),
                                  const SizedBox(
                                    height: kPaddingSmall * 0.5,
                                  ),

                                  // Reserve Camps
                                  ReserveSuiteComponent(
                                    periods: suite.periodos.map((periodo) {
                                      return {
                                        'tempoFormatado':
                                            periodo.tempoFormatado,
                                        'valor': periodo.valor,
                                        'valorTotal': periodo.valorTotal,
                                        'desconto': periodo.desconto,
                                      };
                                    }).toList(),
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
