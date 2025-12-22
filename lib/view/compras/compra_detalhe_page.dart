import 'package:app_eyewear/controller/compra_detalhe_controller.dart';
import 'package:app_eyewear/function.dart';
import 'package:app_eyewear/view/layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CompraDetalhePage extends StatelessWidget {
  const CompraDetalhePage(this.compraRef, {super.key});

  static String tag = '/compra-detalhe-page';
  final DocumentReference compraRef;

  @override
  Widget build(BuildContext context) {
    var controller = CompraDetalheController();
    return Layout.render(
      context,
      FutureBuilder(
        future: controller.loadCompraComItens(compraRef),
        builder:
            (
              BuildContext context,
              AsyncSnapshot<CompraDetalheController> snapshot,
            ) {
              if (snapshot.hasError) {
                return Center(child: Text('Erro: ${snapshot.error}'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: LinearProgressIndicator());
              }

              var data = snapshot.data!;

              // if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              //   return const Center(child: Text('Nenhuma compra'));
              // }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 0),
                    child: Text(
                      'Compra #${data.compra.sequence}',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: Layout.light()),
                    ),
                  ),
                  Expanded(
                    child: Container(
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
                          Text('${data.compra.data?.toFormat()}'),
                          Text('Status: ${data.compra.status}'),
                          SizedBox(height: 10),
                          Text('Total em Itens R\$ ${data.compra.valorItens?.toBRL()}'),
                          Text('Frete por ${data.compra.tipoFrete}: R\$ ${data.compra.valorFrete?.toBRL()}'),
                          SizedBox(height: 10),
                          Text('Total: R\$ ${data.compra.valorTotal?.toBRL()}'),
                          SizedBox(height: 10),
                          Text('Itens:', style: TextStyle(fontSize: 18)),
                          Expanded(
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.items.length,
                              itemBuilder: (BuildContext context, int i) {
                                var item = data.items[i];
                                var descProduto = '${item.quantidade}';  
                                descProduto += 'x R\$${item.valorUnitario?.toBRL()}';
                                descProduto += '\n${item.cor}';
                                
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Layout.dark(.1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: ListTile(
                                    dense: true,
                                    isThreeLine: true,
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        'https://picsum.photos/id/${i + 35}/200/200',
                                      ),
                                    ),
                                    title: Text('${item.titulo}'),
                                    subtitle: Text(descProduto),
                                    trailing: Text('R\$${item.valorTotal?.toBRL()}'),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
      ),
      bottomItemSelected: 1,
    );
  }
}
