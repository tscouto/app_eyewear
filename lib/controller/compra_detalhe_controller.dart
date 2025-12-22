import 'package:app_eyewear/model/compra_model.dart';
import 'package:app_eyewear/model/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompraDetalheController {

  
  late CompraModel compra;
 late List<ItemModel> items;



  Future<CompraDetalheController> loadCompraComItens(DocumentReference compraRef) async {
    compra = await CompraModel.fromDocument(await compraRef.get());
    var query = await FirebaseFirestore.instance
        .collection('item')
        .where('fk_compra', isEqualTo: compraRef)
        .where('excluido', isEqualTo: false)
        .get();
    // var item = await ItemModel.get('/item/xuqvqsDya0341RdhO5fC', full: true);
    // item.delete();

    items = <ItemModel>[];
    for (var doc in query.docs) {
      var item = await ItemModel.fromDocument(doc);
      items.add(item);
    }
    return this;
  }
}
