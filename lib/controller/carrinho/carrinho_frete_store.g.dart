// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carrinho_frete_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CarrinhoFreteStore on _CarrinhoFreteStore, Store {
  late final _$nomeAtom = Atom(
    name: '_CarrinhoFreteStore.nome',
    context: context,
  );

  @override
  String get nome {
    _$nomeAtom.reportRead();
    return super.nome;
  }

  @override
  set nome(String value) {
    _$nomeAtom.reportWrite(value, super.nome, () {
      super.nome = value;
    });
  }

  late final _$valorAtom = Atom(
    name: '_CarrinhoFreteStore.valor',
    context: context,
  );

  @override
  double get valor {
    _$valorAtom.reportRead();
    return super.valor;
  }

  @override
  set valor(double value) {
    _$valorAtom.reportWrite(value, super.valor, () {
      super.valor = value;
    });
  }

  @override
  String toString() {
    return '''
nome: ${nome},
valor: ${valor}
    ''';
  }
}
