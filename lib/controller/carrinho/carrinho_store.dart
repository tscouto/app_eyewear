import 'package:app_eyewear/controller/carrinho/carrinho_frete_store.dart';
import 'package:app_eyewear/controller/carrinho/carrinho_item_store.dart';
import 'package:mobx/mobx.dart';

part 'carrinho_store.g.dart';

class CarrinhoStore extends _CarrinhoStore with _$CarrinhoStore {
  CarrinhoStore();
}

abstract class _CarrinhoStore with Store {
  _CarrinhoStore();

  @observable
  ObservableList<CarrinhoItemStore> items = ObservableList();

  @observable
  CarrinhoFreteStore? frete;

  @computed
  double get valorItems {
    double result = 0.0;
    for (var i in items) {
      result += i.valorItem;
    }
    return result;
  }

  @computed
  double get valorTotal {
    double result = valorItems;

    if (frete != null) {
      result += frete!.valor;
    }
    return result;
  }

  @computed
  double get valorFrete => frete?.valor ?? 0.0;

  @action
  addItem(CarrinhoItemStore item) {
    CarrinhoItemStore? exists = _getItem(item);

    if (exists != null) {
      exists.quantidade++;
    } else {
      items.add(item);
    }

    frete = null;
  }

  @action
  limpar() {
    items.clear();
    frete = null;
  }

  CarrinhoItemStore? _getItem(CarrinhoItemStore item) {
    for (var i in items) {
      if (i.produto.docRef!.id == item.produto.docRef!.id &&
          i.cor == item.cor) {
        return i;
      }
    }
    return null;
  }

  @action
  removeItem(CarrinhoItemStore item) {
    items.remove(item);

    // cliente deve selecionar novamente
    frete = null;
  }
}
