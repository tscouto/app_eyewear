import 'package:app_eyewear/model/categoria_model.dart';
import 'package:app_eyewear/view/home/destaques.dart';
import 'package:app_eyewear/view/home/promo_banner.dart';
import 'package:app_eyewear/view/home/roda_categoria.dart';
import 'package:app_eyewear/view/layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static String tag = '/home-page';
   
  const HomePage( {super.key});

  @override
  Widget build(BuildContext context) {
    var content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(flex: 1, child: PromoBanner()),
        SizedBox(height: 20),
        Expanded(flex: 2, child: HomeDestaques()),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            'Categorias',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Layout.light()),
          ),
        ),
        SizedBox(
          height: 90,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: FutureBuilder(
              future: bucasListaCategorias(),
              builder: (BuildContext context, AsyncSnapshot<List<CategoriaModel>> snapshot) {
                if(snapshot.data == null) {
                  return Center(child: CircularProgressIndicator());
                }
                return RodaCategoria(snapshot.data);
              },
            ),
          ),
        ),
      ],
    );

    return Layout.render(context, content, bottomItemSelected: 0);
  }
  
  Future<List<CategoriaModel>> bucasListaCategorias() async {
    var result = <CategoriaModel>[];
        var query = await FirebaseFirestore.instance.collection('categoria').where('excluido', isEqualTo: false).get();
        for(var doc in query.docs){
         var item = CategoriaModel.fromJson(doc.reference, doc.data());
         result.add(item);
        }
    return result;
  }
}
