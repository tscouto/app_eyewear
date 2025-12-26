import 'package:app_eyewear/controller/users/user_controller.dart';
import 'package:app_eyewear/function/sums_dates/function.dart';
import 'package:app_eyewear/model/categoria_model.dart';
import 'package:app_eyewear/view/layout.dart';
import 'package:app_eyewear/controller/categoria/lista_produto_store.dart';
import 'package:app_eyewear/view/produto/produto_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CategoriaPage extends StatefulWidget {
  const CategoriaPage(this.categoria, {super.key});
  static String tag = '/categoria-page';

  final CategoriaModel categoria;

  @override
  State<CategoriaPage> createState() => _CategoriaPageState();
}

class _CategoriaPageState extends State<CategoriaPage> {
  late ListaProduto listaProduto;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final userController = Provider.of<UserController>(context);

    listaProduto = ListaProduto(widget.categoria, userController.user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    var content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: TextFormField(
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.search, color: Layout.primary()),
              hintText: 'Pesquisa',
              contentPadding: const EdgeInsets.only(left: 20),
              isDense: true,
              fillColor: Layout.light(.6),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Layout.primaryLight()),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Layout.primaryLight()),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onChanged: listaProduto.pesquisa,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 50,
          child: Observer(
            builder: (context) {
              return ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(ListaProdutoOrder.values.length, (
                  iOrder,
                ) {
                  var proOrderValue = ListaProdutoOrder.values[iOrder];
                  var nomeOrderItem = 'Ordenar';
                  switch (proOrderValue) {
                    case ListaProdutoOrder.aParaZ:
                      nomeOrderItem = 'A-Z';
                      break;
                    case ListaProdutoOrder.zparaA:
                      nomeOrderItem = 'Z-A';
                      break;
                    case ListaProdutoOrder.maiorValor:
                      nomeOrderItem = 'Maior valor';
                      break;
                    case ListaProdutoOrder.menorValor:
                      nomeOrderItem = 'Menor valor';
                      break;
                    default:
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 1,
                      vertical: 0,
                    ),
                    child: GestureDetector(
                      child: Chip(
                        label: Text(
                          nomeOrderItem,
                          style: TextStyle(color: Layout.light()),
                        ),
                        backgroundColor: Layout.dark(
                          (listaProduto.ordernacao == proOrderValue) ? 0.6 : 1,
                        ),
                      ),
                      onTap: () {
                        listaProduto.reordenar(proOrderValue);
                      },
                    ),
                  );
                }),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categoria: ${widget.categoria.nome}',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: Layout.light()),
              ),
              Observer(
                builder: (context) {
                  return TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red[300],
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                    ),
                    child: FaIcon(
                      listaProduto.favoritos
                          ? FontAwesomeIcons.solidHeart
                          : FontAwesomeIcons.heart,
                      color: Layout.light(),
                      size: 16,
                    ),
                    onPressed: () {
                      listaProduto.toggleFavoritos();
                    },
                  );
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: Observer(
            builder: (context) {
              if (listaProduto.loading) {
                return Center(child: CircularProgressIndicator());
              }
              if (listaProduto.lista.isEmpty) {
                return Center(child: Text('Nenhum produto encontrado aqui'));
              }
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: listaProduto.lista.length,
                itemBuilder: (BuildContext context, int i) {
                  var produto = listaProduto.lista[i];
                  return GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      decoration: BoxDecoration(
                        color: Layout.light(),
                        borderRadius: BorderRadius.circular(10),

                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(2, 3),
                            color: Layout.dark(.1),
                          ),
                        ],
                      ),
                      child: SizedBox(
                        height: 70,
                        child: Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              child: Image.asset(
                                'assets/images/produtos/prod-${i + 1}.jpg',
                                fit: BoxFit.cover,
                              ),
                              // child: Image.network(
                              //   'https://picsum.photos/id/${i + 1}/200/200',
                              // ),
                              // child: Image.network(produto.imagem!),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    produto.titulo!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Layout.dark(.8),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    produto.preco!.toBRL(),
                                    style: TextStyle(
                                      color: Layout.primaryLight(),
                                      fontSize: 18,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    produto.chamada!,
                                    style: TextStyle(color: Layout.dark(.5)),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            FaIcon(
                              FontAwesomeIcons.angleDoubleRight,
                              color: Layout.primaryLight(),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => ProdutoPage(produto.docRef!),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
    return Layout.render(context, content);
  }
}
