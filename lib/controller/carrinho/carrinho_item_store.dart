import 'package:app_eyewear/model/produto_model.dart';
import 'package:mobx/mobx.dart';

part 'carrinho_item_store.g.dart';

class CarrinhoItemStore = _CarrinhoItemStore with _$CarrinhoItemStore;

abstract class _CarrinhoItemStore with Store {
  _CarrinhoItemStore({required this.produto, this.cor, this.quantidade = 1});

  @observable
  ProdutoModel produto;

  @observable
  int quantidade;

  @observable
  String? cor;

  @computed
  double get valorItem => produto.preco! * quantidade;

  @action
  increment() {
    quantidade++;
  }

  @action
  decrement() {
    quantidade--;
    if (quantidade < 1) {
      quantidade = 1;
    }
  }
}
