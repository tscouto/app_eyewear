import 'package:mobx/mobx.dart';

part 'carrinho_frete_store.g.dart';

class CarrinhoFreteStore extends _CarrinhoFreteStore with _$CarrinhoFreteStore {
  CarrinhoFreteStore(String nome, double valor) : super(nome, valor);
}

abstract class _CarrinhoFreteStore with Store {
  _CarrinhoFreteStore(this.nome, this.valor);

  @observable
  String nome;

  @observable
  double valor;
}
