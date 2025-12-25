import 'package:app_eyewear/controller/users/user_controller.dart';
import 'package:app_eyewear/function/sums_dates/function.dart';
import 'package:app_eyewear/model/compra_model.dart';
import 'package:app_eyewear/view/compras/compra_detalhe_page.dart';
import 'package:app_eyewear/view/layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ComprasPage extends StatelessWidget {
  const ComprasPage({super.key});

  static String tag = '/compras-page';

  @override
  Widget build(BuildContext context) {
    var userController = Provider.of<UserController>(context);
    var queryCompras = FirebaseFirestore.instance
        .collection('compra')
        .where('uid', isEqualTo: userController.user?.uid)
        .orderBy('data', descending: true)
        .snapshots();
    var content = StreamBuilder(
      stream: queryCompras,

      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: LinearProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('Nenhuma compra'));
        }
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int i) {
            var docSnp = snapshot.data!.docs[i];
            var item = CompraModel.fromJson(
              docSnp.reference,
              docSnp.data() as Map<String, dynamic>,
            );

            return Container(
              margin: EdgeInsets.fromLTRB(20, (i == 0 ? 10 : 0), 20, 10),
              decoration: BoxDecoration(
                color: Layout.light(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                isThreeLine: true,
                title: Text(
                  '#${item.sequence} - R\$ ${item.valorTotal?.toBRL()}',
                ),
                subtitle: Text('${item.data?.toFormat()}  \n${item.status}'),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            CompraDetalhePage(docSnp.reference),
                      ),
                    );
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.clipboardList,
                    color: Layout.primary(),
                  ),
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
              'Minhas compras',
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
}
