// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carrinho_item_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CarrinhoItemStore on _CarrinhoItemStore, Store {
  Computed<double>? _$valorItemComputed;

  @override
  double get valorItem => (_$valorItemComputed ??= Computed<double>(
    () => super.valorItem,
    name: '_CarrinhoItemStore.valorItem',
  )).value;

  late final _$produtoAtom = Atom(
    name: '_CarrinhoItemStore.produto',
    context: context,
  );

  @override
  ProdutoModel get produto {
    _$produtoAtom.reportRead();
    return super.produto;
  }

  @override
  set produto(ProdutoModel value) {
    _$produtoAtom.reportWrite(value, super.produto, () {
      super.produto = value;
    });
  }

  late final _$quantidadeAtom = Atom(
    name: '_CarrinhoItemStore.quantidade',
    context: context,
  );

  @override
  int get quantidade {
    _$quantidadeAtom.reportRead();
    return super.quantidade;
  }

  @override
  set quantidade(int value) {
    _$quantidadeAtom.reportWrite(value, super.quantidade, () {
      super.quantidade = value;
    });
  }

  late final _$corAtom = Atom(name: '_CarrinhoItemStore.cor', context: context);

  @override
  String? get cor {
    _$corAtom.reportRead();
    return super.cor;
  }

  @override
  set cor(String? value) {
    _$corAtom.reportWrite(value, super.cor, () {
      super.cor = value;
    });
  }

  late final _$_CarrinhoItemStoreActionController = ActionController(
    name: '_CarrinhoItemStore',
    context: context,
  );

  @override
  dynamic increment() {
    final _$actionInfo = _$_CarrinhoItemStoreActionController.startAction(
      name: '_CarrinhoItemStore.increment',
    );
    try {
      return super.increment();
    } finally {
      _$_CarrinhoItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic decrement() {
    final _$actionInfo = _$_CarrinhoItemStoreActionController.startAction(
      name: '_CarrinhoItemStore.decrement',
    );
    try {
      return super.decrement();
    } finally {
      _$_CarrinhoItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
produto: ${produto},
quantidade: ${quantidade},
cor: ${cor},
valorItem: ${valorItem}
    ''';
  }
}
