import 'package:app_eyewear/model/cor_model.dart';
import 'package:app_eyewear/model/favorito_model.dart';
import 'package:app_eyewear/model/produto_model.dart';
import 'package:app_eyewear/view/layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CompraDetalhePage extends StatelessWidget {
  const CompraDetalhePage(this.id, {super.key});

  static String tag = '/compra-detalhe-page';
  final DocumentReference id;

  @override
  Widget build(BuildContext context) {
    testModels();
    var content = Container(
      decoration: BoxDecoration(
        color: Layout.light(),
        borderRadius: BorderRadius.circular(25),
      ),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Em 20/03/2020 às 14:36'),
          Text('Status: Em análise'),
          SizedBox(height: 10),
          Text('Total em Itens R\$ 70.00'),
          Text('Frete por PAC: R\$ 30.00'),
          SizedBox(height: 10),
          Text('Total: R\$ 100.00'),
          SizedBox(height: 10),
          Text('Itens:', style: TextStyle(fontSize: 18)),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 8,
              itemBuilder: (BuildContext context, int i) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: Layout.dark(.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    dense: true,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        'https://picsum.photos/id/${i + 35}/200/200',
                      ),
                    ),
                    title: Text('Oculos Lindao'),
                    subtitle: Text('3 x R\$15,00'),
                    trailing: Text('R\$45,00'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
    return Layout.render(
      context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 0),
            child: Text(
              'Compra #',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Layout.light()),
            ),
          ),
          Expanded(child: content),
        ],
      ),
      bottomItemSelected: 1,
    );
  }

  void testModels() async {
    var prod = ProdutoModel(
      docRef: FirebaseFirestore.instance
          .collection('produto')
          .doc(), // opcional agora
      titulo: 'Óculos Legal',
      chamada: 'Promoção',
      detalhe: 'Modelo novo 2025',
      preco: 299.99,
    );

    try {
      await prod.insert();
      print('Produto inserido com sucesso! ID: ${prod.docRef?.id}');
    } catch (e) {
      print('Erro ao inserir produto: $e');
    }
  }
}
