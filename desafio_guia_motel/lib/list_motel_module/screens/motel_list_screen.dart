import 'package:desafio_guia_motel/components/bar_itens_suite_component.dart';
import 'package:desafio_guia_motel/components/reservation_value_camp_component.dart';
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {},
              ),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                    ),
                    icon: const Icon(Icons.flash_on, size: 20),
                    label:
                        const Text("ir agora", style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                    ),
                    icon: const Icon(Icons.calendar_today, size: 20),
                    label: const Text("ir outro dia",
                        style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PagedListView<int, GuiaMoteisModel>(
          pagingController: _motelServiceController.pagingController,
          builderDelegate: PagedChildBuilderDelegate(
            firstPageErrorIndicatorBuilder: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Erro ao carregar dados."),
                  ElevatedButton(
                    onPressed: () => _motelServiceController.refreshList(),
                    child: const Text("Tentar Novamente"),
                  ),
                ],
              ),
            ),
            noItemsFoundIndicatorBuilder: (context) => const Center(
              child: Text("Nenhum motel encontrado!"),
            ),
            itemBuilder: (context, motel, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nome e logo do motel
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Image.network(
                            motel.logo,
                            height: 90,
                            width: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              motel.fantasia,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              motel.bairro,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            Text(
                              "${motel.distancia.toStringAsFixed(2)} km",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Listagem horizontal das suítes
                  SizedBox(
                    height: 450, // Ajustado para caber os valores corretamente
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: motel.suites.length,
                      itemBuilder: (context, suiteIndex) {
                        final suite = motel.suites[suiteIndex];

                        return Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: SizedBox(
                            width: 280, // Largura do card
                            child: Column(
                              children: [
                                // Card de Fotos da Suíte + Nome
                                Card(
                                  elevation: 3,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 200,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: suite.fotos.map((foto) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.network(
                                                    foto,
                                                    height: 200,
                                                    width: 280,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          suite.nome,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),

                                // Barra de itens
                                ExpandableIconsRow(
                                  items: suite.categoriaItens.map((item) {
                                    return {
                                      'icone': item.icone,
                                      'nome': item.nome,
                                    };
                                  }).toList(),
                                  iconSize: 30.0,
                                ),
                                const SizedBox(height: 8),

                                // Lista de opções de reserva
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
                  const Divider(height: 32),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
