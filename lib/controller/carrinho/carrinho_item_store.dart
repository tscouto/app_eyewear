import 'package:app_eyewear/model/produto_model.dart';
import 'package:mobx/mobx.dart';

part 'carrinho_item_store.g.dart';

class CarrinhoItemStore extends _CarrinhoItemStore with _$CarrinhoItemStore {
  CarrinhoItemStore(ProdutoModel produto, String? cor, [int quantidade = 1])
    : super(produto: produto, cor: cor, quantidade: quantidade);
}

abstract class _CarrinhoItemStore with Store {
  _CarrinhoItemStore({this.produto, this.cor, this.quantidade = 1});

  @observable
  ProdutoModel? produto;

  @observable
  int quantidade;

  @observable
  String? cor;

  @computed
  double get valorItem => produto!.preco! * quantidade;

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
