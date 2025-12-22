import 'package:app_eyewear/model/abstract_model.dart';
import 'package:app_eyewear/model/produto_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CorModel extends AbstractModel {
  @override
  String get path => 'cor';

  @override
  DocumentReference? docRef;
  DocumentReference? fkProdutoRef;
  ProdutoModel? fkProduto;

  @override
  bool excluido;
  String? texto;

  CorModel({this.texto, this.fkProduto, this.excluido = false});

  CorModel.fromJson(this.docRef, Map<String, dynamic> json)
    : texto = json['texto'],
      fkProdutoRef = json['fk_produto'],
      excluido = json['excluido'] ?? false;

  CorModel.fromDocument(DocumentSnapshot doc)
    : this.fromJson(doc.reference, doc.data() as Map<String, dynamic>);

  @override
  Map<String, dynamic> toJson({bool fullJson = false}) => {
    'texto': texto,
    'fk_produto': fullJson ? fkProduto : referenceFromModel(fkProduto),
    'excluido': excluido,
  };

  static Future<CorModel> get(String documentPath, {full = false}) async {
    var item = await FirebaseFirestore.instance.doc(documentPath).get();
    var result = CorModel.fromJson(
      item.reference,
      item.data() as Map<String, dynamic>,
    );
    final data = item.data() as Map<String, dynamic>;

    if (full && data['fk_produto'] is DocumentReference) {
      await result.loadProduto(data['fk_produto']);
    }

    return result;
  }

  Future<ProdutoModel> loadProduto(DocumentReference itemRef) async {
    final produto = await itemRef.get();

    if (!produto.exists || produto.data() == null) {
      throw Exception('Produto não encontrado');
    }

    fkProduto = ProdutoModel.fromJson(
      produto.reference,
      produto.data() as Map<String, dynamic>,
    );

    return fkProduto!;
  }
}
