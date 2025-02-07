class GuiaMoteisModel {
  final String fantasia;
  final String logo;
  final String bairro;
  final double distancia;
  final int qtdFavoritos;
  final List<SuiteModel> suites;

  GuiaMoteisModel({
    required this.fantasia,
    required this.logo,
    required this.bairro,
    required this.distancia,
    required this.qtdFavoritos,
    required this.suites,
  });

  factory GuiaMoteisModel.fromJson(Map<String, dynamic> json) {
    return GuiaMoteisModel(
      fantasia: json['fantasia'] ?? '',
      logo: json['logo'] ?? '',
      bairro: json['bairro'] ?? '',
      distancia: (json['distancia'] as num).toDouble(),
      qtdFavoritos: (json['qtdFavoritos'] as num).toInt(),
      suites:
          (json['suites'] as List).map((s) => SuiteModel.fromJson(s)).toList(),
    );
  }

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

class SuiteModel {
  final String nome;
  final int qtd;
  final bool exibirQtdDisponiveis;
  final List<String> fotos;
  final List<ItemModel> itens;
  final List<CategoriaItemModel> categoriaItens;
  final List<PeriodoModel> periodos;

  SuiteModel({
    required this.nome,
    required this.qtd,
    required this.exibirQtdDisponiveis,
    required this.fotos,
    required this.itens,
    required this.categoriaItens,
    required this.periodos,
  });

  factory SuiteModel.fromJson(Map<String, dynamic> json) {
    return SuiteModel(
      nome: json['nome'] ?? '',
      qtd: (json['qtd'] as num).toInt(),
      exibirQtdDisponiveis: json['exibirQtdDisponiveis'] ?? false,
      fotos: List<String>.from(json['fotos'] ?? []),
      itens: (json['itens'] as List).map((i) => ItemModel.fromJson(i)).toList(),
      categoriaItens: (json['categoriaItens'] as List)
          .map((c) => CategoriaItemModel.fromJson(c))
          .toList(),
      periodos: (json['periodos'] as List)
          .map((p) => PeriodoModel.fromJson(p))
          .toList(),
    );
  }

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

class ItemModel {
  final String nome;

  ItemModel({required this.nome});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      nome: json['nome'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'nome': nome};
  }
}

class CategoriaItemModel {
  final String nome;
  final String icone;

  CategoriaItemModel({required this.nome, required this.icone});

  factory CategoriaItemModel.fromJson(Map<String, dynamic> json) {
    return CategoriaItemModel(
      nome: json['nome'] ?? '',
      icone: json['icone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'icone': icone,
    };
  }
}

class PeriodoModel {
  final String tempoFormatado;
  final double valor;
  final double valorTotal;
  final bool temCortesia;
  final double? desconto;

  PeriodoModel({
    required this.tempoFormatado,
    required this.valor,
    required this.valorTotal,
    required this.temCortesia,
    this.desconto,
  });

  factory PeriodoModel.fromJson(Map<String, dynamic> json) {
    return PeriodoModel(
      tempoFormatado: json['tempoFormatado'] ?? '',
      valor: (json['valor'] as num).toDouble(),
      valorTotal: (json['valorTotal'] as num).toDouble(),
      temCortesia: json['temCortesia'] ?? false,
      desconto: json['desconto']?['desconto'] != null
          ? (json['desconto']['desconto'] as num).toDouble()
          : null,
    );
  }

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
