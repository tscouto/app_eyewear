// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lista_produto_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ListaProduto on _ListaProdutoBase, Store {
  late final _$loadingAtom = Atom(
    name: '_ListaProdutoBase.loading',
    context: context,
  );

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$listaAtom = Atom(
    name: '_ListaProdutoBase.lista',
    context: context,
  );

  @override
  List<ProdutoModel> get lista {
    _$listaAtom.reportRead();
    return super.lista;
  }

  @override
  set lista(List<ProdutoModel> value) {
    _$listaAtom.reportWrite(value, super.lista, () {
      super.lista = value;
    });
  }

  late final _$ordernacaoAtom = Atom(
    name: '_ListaProdutoBase.ordernacao',
    context: context,
  );

  @override
  ListaProdutoOrder get ordernacao {
    _$ordernacaoAtom.reportRead();
    return super.ordernacao;
  }

  @override
  set ordernacao(ListaProdutoOrder value) {
    _$ordernacaoAtom.reportWrite(value, super.ordernacao, () {
      super.ordernacao = value;
    });
  }

  late final _$favoritosAtom = Atom(
    name: '_ListaProdutoBase.favoritos',
    context: context,
  );

  @override
  bool get favoritos {
    _$favoritosAtom.reportRead();
    return super.favoritos;
  }

  @override
  set favoritos(bool value) {
    _$favoritosAtom.reportWrite(value, super.favoritos, () {
      super.favoritos = value;
    });
  }

  late final _$_ListaProdutoBaseActionController = ActionController(
    name: '_ListaProdutoBase',
    context: context,
  );

  @override
  void pesquisa(String value) {
    final _$actionInfo = _$_ListaProdutoBaseActionController.startAction(
      name: '_ListaProdutoBase.pesquisa',
    );
    try {
      return super.pesquisa(value);
    } finally {
      _$_ListaProdutoBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reordenar(ListaProdutoOrder value) {
    final _$actionInfo = _$_ListaProdutoBaseActionController.startAction(
      name: '_ListaProdutoBase.reordenar',
    );
    try {
      return super.reordenar(value);
    } finally {
      _$_ListaProdutoBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
lista: ${lista},
ordernacao: ${ordernacao},
favoritos: ${favoritos}
    ''';
  }
}
