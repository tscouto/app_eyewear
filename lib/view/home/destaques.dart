import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:app_eyewear/controller/users/user_controller.dart';
import 'package:app_eyewear/function.dart';
import 'package:app_eyewear/model/favorito_model.dart';
import 'package:app_eyewear/model/produto_model.dart';
import 'package:app_eyewear/view/produto/produto_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app_eyewear/view/layout.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;

enum ImageSourceType { asset, firebase, s3 }

class HomeDestaques extends StatelessWidget {
  const HomeDestaques({super.key});

  // 🔹 Firebase
  Future<String> getFirebaseImage(int index) {
    return FirebaseStorage.instance
        .ref('produtos/prod-${index + 1}.jpg')
        .getDownloadURL();
  }

  // 🔹 AWS S3
  Future<String> getS3Image(int index) async {
    final result = await Amplify.Storage.getUrl(
      path: StoragePath.fromString('banners/prod-${index + 1}.jpg'),
    ).result;

    return result.url.toString();
  }

  // 🔹 Widget de imagem
  Widget buildProductImage({
    required ImageSourceType source,
    required int index,
    required double width,
  }) {
    switch (source) {
      case ImageSourceType.asset:
        return Image.asset(
          'assets/images/produtos/prod-${index + 1}.jpg',
          fit: BoxFit.cover,
          width: width,
        );

      case ImageSourceType.firebase:
        return FutureBuilder<String>(
          future: getFirebaseImage(index),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return Image.network(
              snapshot.data!,
              fit: BoxFit.cover,
              width: width,
            );
          },
        );

      case ImageSourceType.s3:
        return FutureBuilder<String>(
          future: getS3Image(index),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return Image.network(
              snapshot.data!,
              fit: BoxFit.cover,
              width: width,
            );
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width - 40;
    final userController = Provider.of<UserController>(context);

    return FutureBuilder<List<ProdutoModel>>(
      future: buscarListaDeProdutos(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhum produto encontrado'));
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const PageScrollPhysics(),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, i) {
            final item = snapshot.data![i];
            

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProdutoPage(item.docRef!),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: width,
                decoration: BoxDecoration(
                  color: Layout.secondary(0.9),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    // 🔹 IMAGEM + FAVORITO
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                        child: Stack(
                          children: [
                            buildProductImage(
                              source: ImageSourceType.asset,
                              index: i,
                              width: width,
                            ),

                            /// ❤️ FAVORITO (CORRETO)
                            Positioned(
                              top: 10,
                              right: 10,
                              child: StreamBuilder<fs.QuerySnapshot>(
                                stream: fs.FirebaseFirestore.instance
                                    .collection('favorito')
                                    .where('fk_produto', isEqualTo: item.docRef)
                                    .where(
                                      'uid',
                                      isEqualTo: userController.user!.uid,
                                    )
                                    .limit(1)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  FavoritoModel? favorito;

                                  if (snapshot.hasData &&
                                      snapshot.data!.docs.isNotEmpty) {
                                    favorito = FavoritoModel.fromDocument(
                                      snapshot.data!.docs.first,
                                    );
                                  }

                                  final isFavorito =
                                      favorito != null &&
                                      favorito.excluido == false;

                                  return TextButton(
                                    onPressed: () {
                                      toggleFavorito(
                                        favorito,
                                        item,
                                        userController.user!.uid,
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.red[300],
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(10),
                                    ),
                                    child: FaIcon(
                                      isFavorito
                                          ? FontAwesomeIcons.solidHeart
                                          : FontAwesomeIcons.heart,
                                      color: Layout.light(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // 🔹 TEXTO
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.titulo!,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(color: Layout.dark()),
                          ),
                          Text(
                            item.chamada!,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(color: Layout.secondaryDark()),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              item.preco!.toBRL(),
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    color: Layout.primary(),
                                    fontSize: 28,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<List<ProdutoModel>> buscarListaDeProdutos() async {
    var produtos = <ProdutoModel>[];

    var query = await FirebaseFirestore.instance
        .collection('produto')
        .where('destaque', isEqualTo: true)
        .where('excluido', isEqualTo: false)
        .get();
    for (var item in query.docs) {
      var produto = ProdutoModel.fromJson(
        item.reference,
        item.data() as Map<String, dynamic>,
      );
      produtos.add(produto);
    }
    return produtos;
  }

  // void toggleFavorito(FavoritoModel? favorito, ProdutoModel item, String uid) {
  //   if (favorito == null && favorito?.fkProduto != item.docRef && favorito!.uid != uid) {
  //     FavoritoModel(
  //       fkProduto: item,
  //       uid: uid,
  //       excluido: false,
  //     ).insert(); // 🔥 exatamente como no código antigo
  //   } else {
  //     var inverter = favorito!.excluido = !favorito.excluido;

  //     FavoritoModel(
  //       uid: uid,
  //       fkProduto: item,
  //       excluido: inverter,
  //     ).update();
  //   }

  // }

 void toggleFavorito(
    FavoritoModel? favorito,
    ProdutoModel item,
    String uid,
  ) {
    if (favorito == null) {
      FavoritoModel(
        fkProduto: item.docRef!,
        uid: uid,
        excluido: false,
      ).insert();
    } else {
      favorito.excluido = !favorito.excluido;
      favorito.update();
    }
  }
}



//'assets/images/produtos/prod-${i + 1}.jpg' // 
//Future<String> getFirebaseImage(int i) { 
//// return FirebaseStorage.instance // 
///.ref('produtos/prod-${i + 1}.jpg') 
///// .getDownloadURL(); // } 
///// Future<String> getS3Image(inrt i) async { 
///// final result = await Amplify.Storage.getUrl( 
///// path: StoragePath.fromString('banners/prod-${i + 1}.jpg'), 
///// ).result; // return result.url.toString(); 
///// }