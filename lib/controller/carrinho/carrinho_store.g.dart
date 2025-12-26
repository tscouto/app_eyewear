// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carrinho_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CarrinhoStore on _CarrinhoStore, Store {
  Computed<double>? _$valorItemsComputed;

  @override
  double get valorItems => (_$valorItemsComputed ??= Computed<double>(
    () => super.valorItems,
    name: '_CarrinhoStore.valorItems',
  )).value;
  Computed<double>? _$valorTotalComputed;

  @override
  double get valorTotal => (_$valorTotalComputed ??= Computed<double>(
    () => super.valorTotal,
    name: '_CarrinhoStore.valorTotal',
  )).value;
  Computed<double>? _$valorFreteComputed;

  @override
  double get valorFrete => (_$valorFreteComputed ??= Computed<double>(
    () => super.valorFrete,
    name: '_CarrinhoStore.valorFrete',
  )).value;

  late final _$itemsAtom = Atom(name: '_CarrinhoStore.items', context: context);

  @override
  ObservableList<CarrinhoItemStore> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<CarrinhoItemStore> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$freteAtom = Atom(name: '_CarrinhoStore.frete', context: context);

  @override
  CarrinhoFreteStore? get frete {
    _$freteAtom.reportRead();
    return super.frete;
  }

  @override
  set frete(CarrinhoFreteStore? value) {
    _$freteAtom.reportWrite(value, super.frete, () {
      super.frete = value;
    });
  }

  late final _$_CarrinhoStoreActionController = ActionController(
    name: '_CarrinhoStore',
    context: context,
  );

  @override
  dynamic addItem(CarrinhoItemStore item) {
    final _$actionInfo = _$_CarrinhoStoreActionController.startAction(
      name: '_CarrinhoStore.addItem',
    );
    try {
      return super.addItem(item);
    } finally {
      _$_CarrinhoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic limpar() {
    final _$actionInfo = _$_CarrinhoStoreActionController.startAction(
      name: '_CarrinhoStore.limpar',
    );
    try {
      return super.limpar();
    } finally {
      _$_CarrinhoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeItem(CarrinhoItemStore item) {
    final _$actionInfo = _$_CarrinhoStoreActionController.startAction(
      name: '_CarrinhoStore.removeItem',
    );
    try {
      return super.removeItem(item);
    } finally {
      _$_CarrinhoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
items: ${items},
frete: ${frete},
valorItems: ${valorItems},
valorTotal: ${valorTotal},
valorFrete: ${valorFrete}
    ''';
  }
}
