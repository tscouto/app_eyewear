import 'package:mobx/mobx.dart';

part 'carrinho_frete_store.g.dart';

class CarrinhoFreteStore extends _CarrinhoFreteStore with _$CarrinhoFreteStore {
  CarrinhoFreteStore({
    required String nome,
    required double valor,
    required int prazo,
  }) : super(nome: nome, valor: valor, prazo: prazo);
}

abstract class _CarrinhoFreteStore with Store {
  _CarrinhoFreteStore({
    required this.nome,
    required this.valor,
    required this.prazo,
  });

  @observable
  String nome;

  @observable
  double valor;

  @observable
  int prazo;
}
