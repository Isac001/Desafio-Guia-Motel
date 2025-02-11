import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import '../models/guia_motel_models.dart';
import '../services/motel_service.dart';

/// Provider class responsible for managing the state of motels in the application.
class MotelProvider with ChangeNotifier {
  /// List of motels retrieved from the API.
  List<MotelGuideModel> motels = [];

  /// Stores the currently selected zone.
  /// Default value is 'Zona Norte'.
  String selectedZone = 'Zona Norte';

  /// Indicates whether the data is being loaded.
  bool isLoading = false;

  /// Stores error messages related to fetching data.
  String errorMessage = '';

  /// Controller for handling infinite scrolling pagination.
  final PagingController<int, MotelGuideModel> pagingController =
      PagingController<int, MotelGuideModel>(firstPageKey: 0);

  /// Service responsible for fetching motels from the API.
  final MotelService _motelService;

  /// Currency formatter to display prices in Brazilian Real (R$).
  final NumberFormat currencyFormatter =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  /// Constructor that initializes the provider and sets up pagination.
  MotelProvider(this._motelService) {
    pagingController.addPageRequestListener((pageKey) async {
      await lazyLoad(pageKey);
    });
  }

  /// Fetches the list of motels from the API and updates the state.
  Future<void> fetchMotels() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      /// Fetch motels from the API.
      final List<MotelGuideModel> fetchedMoteis =
          await _motelService.fetchGuiaMoteis();

      /// Store the fetched motels in the list.
      motels = fetchedMoteis;
    } catch (error) {
      /// Store an error message in case of failure.
      errorMessage = 'Erro ao carregar motéis. Tente novamente.';
    } finally {
      /// Set loading to false and notify listeners.
      isLoading = false;
      notifyListeners();
    }
  }

  /// Updates the selected zone and notifies listeners.
  void updateZone(String zone) {
    selectedZone = zone;
    notifyListeners();
  }

  /// Handles lazy loading of more motels when scrolling.
  Future<void> lazyLoad(int pageKey) async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      /// Fetch motels from the API.
      final List<MotelGuideModel> fetchedMoteis =
          await _motelService.fetchGuiaMoteis();

      /// If there are no more motels to load, stop pagination.
      if (fetchedMoteis.isEmpty) {
        pagingController.appendLastPage([]);
        return;
      }

      /// Filter out motels that are already in the list to avoid duplicates.
      final List<MotelGuideModel> newMoteis = fetchedMoteis.where((motel) {
        return !motels.any((existing) => existing.fantasia == motel.fantasia);
      }).toList();

      /// If there are new motels, append them to the pagination controller.
      if (newMoteis.isNotEmpty) {
        pagingController.appendPage(newMoteis, pageKey + 1);
        motels.addAll(newMoteis);
      } else {
        /// If no new motels were found, mark the last page.
        pagingController.appendLastPage([]);
      }
    } catch (error) {
      /// Store an error message and set it in the pagination controller.
      errorMessage = 'Erro ao carregar motéis. Tente novamente.';
      pagingController.error = error;
    } finally {
      /// Set loading to false and notify listeners.
      isLoading = false;
      notifyListeners();
    }
  }

  /// Clears the current list of motels and refreshes the data.
  Future<void> refreshList() async {
    motels.clear();
    pagingController.refresh();
    notifyListeners();
  }
}
