import 'package:app_eyewear/controller/user_controller.dart';
import 'package:app_eyewear/model/favorito_model.dart';
import 'package:app_eyewear/model/produto_model.dart';
import 'package:app_eyewear/view/layout.dart';
import 'package:app_eyewear/view/produto/produto_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FavoritosPage extends StatelessWidget {
  const FavoritosPage({super.key});
  static String tag = '/favoritos-page';

  @override
  Widget build(BuildContext context) {
    var userController = Provider.of<UserController>(context);

    var favoritoSnapshots = FirebaseFirestore.instance
        .collection('favorito')
        .where('excluido', isEqualTo: false)
        .where('uid', isEqualTo: userController.user!.uid)
        .snapshots();

    Widget content = StreamBuilder(
      stream: favoritoSnapshots,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: LinearProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('Nenhum favorito ainda'));
        }

        return ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (BuildContext context, int i) {
            var favoritoDoc = snapshot.data!.docs[i];
            var dadosFavorito = favoritoDoc.data() as Map<String, dynamic>;
            var favorito = FavoritoModel.fromJson(
              favoritoDoc.reference,
              dadosFavorito,
            );

           
            // bool jaExecutou = false;

            // if (!jaExecutou) {
            //   jaExecutou = true;
            //   FirebaseFirestore.instance
            //       .doc('/favorito/IY4yfpxmXCjpXebGNoft')
            //       .get()
            //       .then((docSnp) async {
            //         final favorito = FavoritoModel.fromJson(
            //           docSnp.reference,
            //           docSnp.data() as Map<String, dynamic>,
            //         );

            //         favorito
            //             .loadProduto(
            //               docSnp.get('fk_produto') as DocumentReference,
            //             )
            //             .then((value) {
            //               FirebaseFirestore.instance
            //                   .collection('favorito')
            //                   .add(favorito.toJson());
            //             });
            //         // // carrega o produto
            //         await favorito.loadProduto(
            //           docSnp.get('fk_produto') as DocumentReference,
            //         );
            //       });
            // }

            final DocumentReference produtoRef =
                favoritoDoc.get('fk_produto') as DocumentReference;

            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProdutoPage(produtoRef.id),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(20, (i == 0 ? 10 : 0), 20, 10),
                decoration: BoxDecoration(
                  color: Layout.light(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FutureBuilder<ProdutoModel>(
                  future: favorito.loadProduto(),

                  builder:
                      (
                        BuildContext context,
                        AsyncSnapshot<ProdutoModel> snpsProd,
                      ) {
                        if (snpsProd.hasError) {
                          return Center(child: Text('Erro: ${snpsProd.error}'));
                        }

                        if (snpsProd.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(25),
                              child: LinearProgressIndicator(),
                            ),
                          );
                        }
                        if (!snpsProd.hasData) {
                          return const SizedBox(
                            height: 90,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        final produto = snpsProd.data!;
                        final titulo = produto.titulo ?? '';
                        final chamada = produto.chamada ?? '';

                        return ListTile(
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          leading: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  color: Layout.dark(.3),
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.asset(
                                'assets/images/produtos/prod-${i + 1}.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(titulo.toString()),
                          subtitle: Text(chamada.toString()),
                          trailing: IconButton(
                            onPressed: () {
                              favoritoDoc.reference.update({'excluido': true});
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.solidHeart,

                              color: Colors.red[300],
                            ),
                          ),
                        );
                      },
                ),
              ),
            );
          },
        );
      },
    );
    return Layout.render(
      context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 0),
            child: Text(
              'Favoritos',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Layout.light()),
            ),
          ),
          Expanded(child: content),
        ],
      ),
      bottomItemSelected: 2,
    );
  }
}
