/// WARNING: The field names are in Portuguese because the JSON structure uses Portuguese keys.

/// Represents a motel in the guide, containing general information and available suites.
class MotelGuideModel {
  /// Name of the motel (brand/fantasy name).
  final String fantasia;

  /// URL of the motel's logo image.
  final String logo;

  /// Neighborhood where the motel is located.
  final String bairro;

  /// Distance of the motel from the user's location.
  final double distancia;

  /// Number of users who have marked this motel as a favorite.
  final int qtdFavoritos;

  /// List of suites available in the motel.
  final List<SuiteModel> suites;

  /// Constructor for the MotelGuideModel class.
  MotelGuideModel.MotelGuideModel({
    required this.fantasia,
    required this.logo,
    required this.bairro,
    required this.distancia,
    required this.qtdFavoritos,
    required this.suites,
  });

  /// Factory constructor to create an instance from a JSON object.
  factory MotelGuideModel.fromJson(Map<String, dynamic> json) {
    return MotelGuideModel.MotelGuideModel(
      fantasia: json['fantasia'] ?? '',
      logo: json['logo'] ?? '',
      bairro: json['bairro'] ?? '',
      distancia: (json['distancia'] as num).toDouble(),
      qtdFavoritos: (json['qtdFavoritos'] as num).toInt(),
      suites:
          (json['suites'] as List).map((s) => SuiteModel.fromJson(s)).toList(),
    );
  }

  /// Converts an instance of MotelGuideModel into a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'fantasia': fantasia,
      'logo': logo,
      'bairro': bairro,
      'distancia': distancia,
      'qtdFavoritos': qtdFavoritos,
      'suites': suites.map((s) => s.toJson()).toList(),
    };
  }
}

/// Represents a suite within a motel, including its details and available booking periods.
class SuiteModel {
  /// Name of the suite.
  final String nome;

  /// Number of available suites of this type.
  final int qtd;

  /// Indicates whether the number of available suites should be displayed.
  final bool exibirQtdDisponiveis;

  /// List of URLs for suite images.
  final List<String> fotos;

  /// List of included items in the suite.
  final List<ItemModel> itens;

  /// List of item categories available in the suite.
  final List<ItemCategoryModel> categoriaItens;

  /// List of booking periods available for this suite.
  final List<PeriodModel> periodos;

  /// Constructor for the SuiteModel class.
  SuiteModel({
    required this.nome,
    required this.qtd,
    required this.exibirQtdDisponiveis,
    required this.fotos,
    required this.itens,
    required this.categoriaItens,
    required this.periodos,
  });

  /// Factory constructor to create an instance from a JSON object.
  factory SuiteModel.fromJson(Map<String, dynamic> json) {
    return SuiteModel(
      nome: json['nome'] ?? '',
      qtd: (json['qtd'] as num).toInt(),
      exibirQtdDisponiveis: json['exibirQtdDisponiveis'] ?? false,
      fotos: List<String>.from(json['fotos'] ?? []),
      itens: (json['itens'] as List).map((i) => ItemModel.fromJson(i)).toList(),
      categoriaItens: (json['categoriaItens'] as List)
          .map((c) => ItemCategoryModel.fromJson(c))
          .toList(),
      periodos: (json['periodos'] as List)
          .map((p) => PeriodModel.fromJson(p))
          .toList(),
    );
  }

  /// Converts an instance of SuiteModel into a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'qtd': qtd,
      'exibirQtdDisponiveis': exibirQtdDisponiveis,
      'fotos': fotos,
      'itens': itens.map((i) => i.toJson()).toList(),
      'categoriaItens': categoriaItens.map((c) => c.toJson()).toList(),
      'periodos': periodos.map((p) => p.toJson()).toList(),
    };
  }
}

/// Represents an item included in a suite.
class ItemModel {
  /// Name of the item.
  final String nome;

  /// Constructor for the ItemModel class.
  ItemModel({required this.nome});

  /// Factory constructor to create an instance from a JSON object.
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      nome: json['nome'] ?? '',
    );
  }

  /// Converts an instance of ItemModel into a JSON object.
  Map<String, dynamic> toJson() {
    return {'nome': nome};
  }
}

/// Represents a category of items available in a suite.
class ItemCategoryModel {
  /// Name of the category.
  final String nome;

  /// Icon representing the category.
  final String icone;

  /// Constructor for the ItemCategoryModel class.
  ItemCategoryModel({required this.nome, required this.icone});

  /// Factory constructor to create an instance from a JSON object.
  factory ItemCategoryModel.fromJson(Map<String, dynamic> json) {
    return ItemCategoryModel(
      nome: json['nome'] ?? '',
      icone: json['icone'] ?? '',
    );
  }

  /// Converts an instance of ItemCategoryModel into a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'icone': icone,
    };
  }
}

/// Represents a booking period available for a suite.
class PeriodModel {
  /// Formatted time duration of the period.
  final String tempoFormatado;

  /// Base price for this period.
  final double valor;

  /// Total price for this period, including any applicable discounts.
  final double valorTotal;

  /// Indicates whether there is a courtesy (e.g., free period).
  final bool temCortesia;

  /// Discount amount applied to this period (if any).
  final double? desconto;

  /// Constructor for the PeriodModel class.
  PeriodModel({
    required this.tempoFormatado,
    required this.valor,
    required this.valorTotal,
    required this.temCortesia,
    this.desconto,
  });

  /// Factory constructor to create an instance from a JSON object.
  factory PeriodModel.fromJson(Map<String, dynamic> json) {
    return PeriodModel(
      tempoFormatado: json['tempoFormatado'] ?? '',
      valor: (json['valor'] as num).toDouble(),
      valorTotal: (json['valorTotal'] as num).toDouble(),
      temCortesia: json['temCortesia'] ?? false,
      desconto: json['desconto']?['desconto'] != null
          ? (json['desconto']['desconto'] as num).toDouble()
          : null,
    );
  }

  /// Converts an instance of PeriodModel into a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'tempoFormatado': tempoFormatado,
      'valor': valor,
      'valorTotal': valorTotal,
      'temCortesia': temCortesia,
      'desconto': desconto,
    };
  }
}
