

import 'package:app_eyewear/model/abstract_model.dart';
import 'package:app_eyewear/model/produto_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FotoModel extends AbstractModel {
  @override
  String get path => 'foto';

  @override
  DocumentReference? docRef;

  @override
  bool excluido;

  String? url;
  ProdutoModel? fkProduto;

  FotoModel({
    this.fkProduto,
    this.url,
    this.excluido = false,
  });

  FotoModel.fromJson(this.docRef, Map<String, dynamic> json)
      : url = json['url'],
        fkProduto =
            (json['fk_produto'] is ProdutoModel) ? json['fk_produto'] : null,
        excluido = json['excluido'];

  FotoModel.fromDocument(DocumentSnapshot doc)
      : this.fromJson(doc.reference, doc.data() as Map<String, dynamic>);

  @override
  Map<String, dynamic> toJson({bool fullJson = false}) => {
        'url': url,
        'fk_produto': fullJson ? fkProduto : fkProduto?.docRef,
        'excluido': excluido,
      };

  static Future<FotoModel> get(String documentPath, {full = false}) async {
    var item = await FirebaseFirestore.instance.doc(documentPath).get();
    final data = item.data() as Map<String, dynamic>?;
    if (data == null) {
      throw StateError('Document at $documentPath has no data');
    }
    var result = FotoModel.fromJson(item.reference, data);

    if (full && data['fk_produto'] is DocumentReference) {
      await result.loadProduto(data['fk_produto'] as DocumentReference);
    }

    return result;
  }

  Future<ProdutoModel?> loadProduto(DocumentReference itemRef) async {
    var produto = await itemRef.get();
    fkProduto =
        produto.exists ? ProdutoModel.fromJson(itemRef, produto.data() as Map<String, dynamic>) : null;
    return fkProduto;
  }
}
