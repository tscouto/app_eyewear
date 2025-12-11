import 'package:app_eyewear/view/compras/compra_detalhe_page.dart';
import 'package:app_eyewear/view/layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ComprasPage extends StatelessWidget {
  const ComprasPage({super.key});

  static String tag = '/compras-page';

  @override
  Widget build(BuildContext context) {
    var content = ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 9,
        itemBuilder: (BuildContext context, int i) {
            return Container(
                margin: EdgeInsets.fromLTRB(20,(i == 0 ? 10 : 0 ) , 20, 10),
                decoration: BoxDecoration(
                    color: Layout.light(),
                    borderRadius: BorderRadius.circular(10)               
                    ),
                    child: ListTile(
                        isThreeLine: true,
                        title: Text('#125 - R\$ 125,80'),
                        subtitle: Text('Em 15/05/2020 às 20:54 \nEm análise'),
                        trailing: IconButton(onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CompraDetalhePage(1)
                            
                            ));
                        }, icon: FaIcon(FontAwesomeIcons.clipboardList ,color: Layout.primary(),),
                    ),
                    ),
            );
        });
    return Layout.render(
        context,  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 20, bottom: 0),
                child: Text('Minhas compras', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Layout.light()),),),
                Expanded(child: content)
            ],
        ), bottomItemSelected: 1);
  }
}