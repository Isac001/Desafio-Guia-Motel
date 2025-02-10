import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import '../models/guia_motel_models.dart';
import '../services/motel_service.dart';

class MotelServiceController extends GetxController {
  RxList<GuiaMoteisModel> moteis = <GuiaMoteisModel>[].obs;
  final PagingController<int, GuiaMoteisModel> pagingController =
      PagingController<int, GuiaMoteisModel>(firstPageKey: 0);

  final MotelService _motelService;
  final NumberFormat currencyFormatter =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) async {
      await lazyLoad(pageKey);
    });
  }

  MotelServiceController({required MotelService motelService})
      : _motelService = motelService;

  Future<void> lazyLoad(int pageKey) async {
    try {
      final List<GuiaMoteisModel> fetchedMoteis =
          await _motelService.fetchGuiaMoteis();

      if (fetchedMoteis.isEmpty) {
        pagingController.appendLastPage([]);
        return;
      }

      final List<GuiaMoteisModel> newMoteis = fetchedMoteis.where((motel) {
        return !moteis.any((existing) => existing.fantasia == motel.fantasia);
      }).toList();

      if (newMoteis.isNotEmpty) {
        pagingController.appendPage(newMoteis, pageKey + 1);
        moteis.addAll(newMoteis);
      } else {
        pagingController.appendLastPage([]); 
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<void> refreshList() async {
    moteis.clear();
    pagingController.refresh();
  }
}
