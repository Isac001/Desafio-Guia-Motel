import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import '../models/guia_motel_models.dart';
import '../services/motel_service.dart';

class MotelProvider with ChangeNotifier {
  List<GuiaMoteisModel> motels = [];
  String selectedZone = 'Zona Norte'; // 🔹 Agora armazena a zona selecionada
  bool isLoading = false;
  String errorMessage = '';
  final PagingController<int, GuiaMoteisModel> pagingController =
      PagingController<int, GuiaMoteisModel>(firstPageKey: 0);

  final MotelService _motelService;
  final NumberFormat currencyFormatter =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  MotelProvider(this._motelService) {
    pagingController.addPageRequestListener((pageKey) async {
      await lazyLoad(pageKey);
    });
  }

  /// 🔄 Busca os motéis da API
  Future<void> fetchMotels() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      final List<GuiaMoteisModel> fetchedMoteis =
          await _motelService.fetchGuiaMoteis();

      motels = fetchedMoteis;
    } catch (error) {
      errorMessage = 'Erro ao carregar motéis. Tente novamente.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// 📌 Atualiza a zona selecionada
  void updateZone(String zone) {
    selectedZone = zone;
    notifyListeners();
  }

  /// 🔄 Carrega mais páginas para rolagem infinita
  Future<void> lazyLoad(int pageKey) async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      final List<GuiaMoteisModel> fetchedMoteis =
          await _motelService.fetchGuiaMoteis();

      if (fetchedMoteis.isEmpty) {
        pagingController.appendLastPage([]);
        return;
      }

      final List<GuiaMoteisModel> newMoteis = fetchedMoteis.where((motel) {
        return !motels.any((existing) => existing.fantasia == motel.fantasia);
      }).toList();

      if (newMoteis.isNotEmpty) {
        pagingController.appendPage(newMoteis, pageKey + 1);
        motels.addAll(newMoteis);
      } else {
        pagingController.appendLastPage([]);
      }
    } catch (error) {
      errorMessage = 'Erro ao carregar motéis. Tente novamente.';
      pagingController.error = error;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// 🔄 Limpa a lista e recarrega os motéis
  Future<void> refreshList() async {
    motels.clear();
    pagingController.refresh();
    notifyListeners();
  }
}
