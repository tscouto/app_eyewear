
import 'package:app_eyewear/controller/carrinho/carrinho_item_store.dart';
import 'package:app_eyewear/controller/carrinho/carrinho_store.dart';
import 'package:app_eyewear/function/sums_dates/function.dart';
import 'package:app_eyewear/model/produto_model.dart';
import 'package:app_eyewear/view/carrinho/carrinho_page.dart';
import 'package:app_eyewear/view/layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProdutoPage extends StatefulWidget {
  ProdutoPage(this.produtoRef, {super.key});
  static String tag = '/produto-page';

  final DocumentReference produtoRef;

  @override
  State<ProdutoPage> createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  int currentPic = 0;
  int corSelecionada = 0;
  List<String> imagens = [];
  List<String> cores = [];

  ProdutoModel? produto;

  @override
  Widget build(BuildContext context) {
    var sController = ScrollController();
    var listViewItemWidth = MediaQuery.of(context).size.width - 40;
    var carrinho = Provider.of<CarrinhoStore>(context);

    var content = FutureBuilder(
      future: buscaDetalhesProduto(),
      builder: (context, AsyncSnapshot<ProdutoModel> snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }

        produto = snapshot.data;

        return Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width / 2,
                child: Stack(
                  children: [
                    ListView.builder(
                      controller: sController,
                      scrollDirection: Axis.horizontal,
                      physics: PageScrollPhysics(),
                      itemCount: imagens.length,
                      itemBuilder: (BuildContext context, int i) {
                        return SizedBox(
                          width: listViewItemWidth,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                            // child: Image.network(imagens[i], fit: BoxFit.cover),
                            child: Image.asset(
                              'assets/images/produtos/prod-${i + 1}.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                    Container(
                      width: listViewItemWidth,
                      padding: const EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[300],
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(10),
                          ),
                          child: FaIcon(
                            FontAwesomeIcons.solidHeart,
                            color: Layout.light(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: listViewItemWidth,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            sController.animateTo(
                              (currentPic - 1) * listViewItemWidth,
                              duration: Duration(microseconds: 700),
                              curve: Curves.ease,
                            );
                            currentPic--;
                            if (currentPic < 0) {
                              currentPic = 0;
                            }
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.chevronLeft,
                            color: Layout.light(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: listViewItemWidth,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {
                            sController.animateTo(
                              (currentPic + 1) * listViewItemWidth,
                              duration: Duration(microseconds: 700),
                              curve: Curves.ease,
                            );
                            currentPic++;
                            if (currentPic > imagens.length - 1) {
                              currentPic = imagens.length - 1;
                            }
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.chevronRight,
                            color: Layout.light(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Layout.light(),
                  height: 100,
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width:
                                (MediaQuery.of(context).size.width - 70) * .60,
                            child: Text(
                              produto!.titulo!,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(color: Layout.primaryDark()),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              produto!.preco!.toBRL(),
                              textAlign: TextAlign.end,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(color: Layout.primary()),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: List<Widget>.generate(cores.length, (iCor) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: GestureDetector(
                              child: Chip(
                                label: Text(
                                  cores[iCor],
                                  style: TextStyle(
                                    color: (corSelecionada == iCor
                                        ? Colors.white
                                        : Colors.black),
                                  ),
                                ),
                                backgroundColor: (corSelecionada == iCor)
                                    ? Layout.primaryDark(.6)
                                    : Colors.grey[300],
                              ),
                              onTap: () {
                                setState(() {
                                  corSelecionada = iCor;
                                });
                              },
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: ListView(
                          children: <Widget>[
                            Text(
                              'Detalhes',
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(color: Layout.primaryDark()),
                            ),
                            SizedBox(height: 10),
                            Text(produto!.detalhe!),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Layout.primary(),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Comprar',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                onTap: () {
                  carrinho.addItem(
                    CarrinhoItemStore(
                      produto:produto!,
                      cor:cores.isNotEmpty ? cores[corSelecionada] : 'Cor única',
                    ),
                  );
                  Navigator.of(context).pushNamed(CarrinhoPage.tag);
                },
              ),
            ],
          ),
        );
      },
    );
    return Layout.render(context, content);
  }

  Future<ProdutoModel> buscaDetalhesProduto() async {
    // Isso impede de fazer consultas repetidas ao usar
    // o setState para marcar a cor selecionada
    if (produto != null) {
      return produto!;
    }
    var docSnp = await widget.produtoRef.get();

    var result = ProdutoModel.fromDocument(docSnp);
    imagens = [];
    imagens.add(result.imagem!);

    var fotos = await FirebaseFirestore.instance
        .collection('foto')
        .where('fk_produto', isEqualTo: widget.produtoRef)
        .where('excluido', isEqualTo: false)
        .get();

    for (var foto in fotos.docs) {
      imagens.add(foto.get('url'));
    }

    cores = [];
    var coresDoc = await FirebaseFirestore.instance
        .collection('cor')
        .where('fk_produto', isEqualTo: widget.produtoRef)
        .where('excluido', isEqualTo: false)
        .get();

    for (var cor in coresDoc.docs) {
      cores.add(cor.get('texto'));
    }
    return result;
  }
}
