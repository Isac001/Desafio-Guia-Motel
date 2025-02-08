import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import '../models/guia_motel_models.dart';
import '../services/motel_service.dart';

class MotelServiceController extends GetxController {
  

  RxList<GuiaMoteisModel> moteis = <GuiaMoteisModel>[].obs;

  final PagingController<int, GuiaMoteisModel> pagingController =
      PagingController<int, GuiaMoteisModel>(firstPageKey: 0);

  final MotelService _motelService = MotelService();

  final NumberFormat currencyFormatter =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  Future<void> lazyLoad(int pageKey) async {
    try {
      final List<GuiaMoteisModel> fetchedMoteis =
          await _motelService.fetchGuiaMoteis();

      if (fetchedMoteis.isEmpty) {
        pagingController.appendLastPage([]);
      } else {
        pagingController.appendLastPage(fetchedMoteis);
        moteis.addAll(fetchedMoteis);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<void> refreshList() async {
    return Future.sync(() {
      moteis.clear();
      pagingController.refresh();
    });
  }

  void onInitt() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) async {
      await lazyLoad(pageKey);
    });
  }
}
