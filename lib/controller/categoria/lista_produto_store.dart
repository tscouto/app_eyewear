import 'package:app_eyewear/model/categoria_model.dart';
import 'package:app_eyewear/model/favorito_model.dart';
import 'package:app_eyewear/model/produto_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';

part 'lista_produto_store.g.dart';

enum ListaProdutoOrder { maiorValor, menorValor, aParaZ, zparaA }

class ListaProduto extends _ListaProdutoBase with _$ListaProduto {
  ListaProduto(CategoriaModel categoriaModel, String uid)
    : super(categoriaModel, uid);
}

abstract class _ListaProdutoBase with Store {
  final CategoriaModel categoriaModel;
  final String uid;
  _ListaProdutoBase(this.categoriaModel, this.uid) {
    _filtraLista();
  }

  String _termoPesquisa = '';

  List<FavoritoModel>? _listaFavoritos;

  List<ProdutoModel>? _listaProdutos;
  @observable
  bool loading = true;

  @observable
  List<ProdutoModel> lista = [];

  @observable
  ListaProdutoOrder ordernacao = ListaProdutoOrder.aParaZ;

  @action
  void pesquisa(String value) {
    _termoPesquisa = value.toLowerCase();
    _filtraLista();
  }

  @action
  void reordenar(ListaProdutoOrder value) {
    ordernacao = value;
    _filtraLista();
  }

  @action
  toggleFavoritos() {
    favoritos = !favoritos;
    _filtraLista();
  }

  @observable
  bool favoritos = false;

  void _filtraLista() async {
    loading = true;

    if (_listaFavoritos == null) {
      await _carregaListaFavoritos();
    }

    if (_listaProdutos == null) {
      await _carregaListaProdutos();
    }

    final List<ProdutoModel> filtrados = [];

    for (var item in _listaProdutos!) {

          if(favoritos) {
            var exists = false;
           for(var favorito in _listaFavoritos!) {
            if(favorito.excluido == false && favorito.fkProduto.path == item.docRef!.path ) {
              exists = true;
              break;
            }
           }
           if(!exists) {
            continue;
           }
          }

      if (_termoPesquisa.isNotEmpty) {
        final titulo = (item.titulo ?? '').toLowerCase();
        final detalhe = (item.detalhe ?? '').toLowerCase();
        final chamada = (item.chamada ?? '').toLowerCase();

        if (titulo.contains(_termoPesquisa) ||
            detalhe.contains(_termoPesquisa) ||
            chamada.contains(_termoPesquisa)) {
          filtrados.add(item);
        }
      } else {
        filtrados.add(item);
      }
    }

    lista = filtrados;
    loading = false;

    if (lista.isNotEmpty) {
      lista.sort((a, b) {
        var result = 0;
        switch (ordernacao) {
          case ListaProdutoOrder.aParaZ:
            result = a.titulo!.compareTo(b.titulo!);
            break;
          case ListaProdutoOrder.zparaA:
            result = b.titulo!.compareTo(a.titulo!);
            break;
          case ListaProdutoOrder.maiorValor:
            result = b.preco!.compareTo(a.preco!);
            break;
          case ListaProdutoOrder.menorValor:
            result = a.preco!.compareTo(b.preco!);
            break;
          default:
            throw Exception('Ordernacao invalida');
        }
        return result;
      });
    }
  }

  Future<void> _carregaListaProdutos() async {
    _listaProdutos = [];


    var produtosDocs = await FirebaseFirestore.instance
        .collection('produto')
        .where('fk_categoria', isEqualTo: categoriaModel.docRef)
        .where('excluido', isEqualTo: false)
        .get();

    for (var prodDoc in produtosDocs.docs) {
      var item = ProdutoModel.fromDocument(prodDoc);
      _listaProdutos!.add(item);
    }
  }

  Future<void> _carregaListaFavoritos() async {
    _listaFavoritos = [];

    var favoritosDocs = await FirebaseFirestore.instance
        .collection('favorito')
        .where('uid', isEqualTo: uid)
        .get();

    for (var favDoc in favoritosDocs.docs) {
      var favorito = FavoritoModel.fromDocument(favDoc);

      await favorito.loadProduto();

      _listaFavoritos!.add(favorito);
    }
  }
}
