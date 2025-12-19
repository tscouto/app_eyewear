import 'package:cloud_firestore/cloud_firestore.dart';
import 'abstract_model.dart';
import 'produto_model.dart';

class FavoritoModel extends AbstractModel {
  @override
  String get path => 'favorito';

  @override
  DocumentReference? docRef;

  @override
  bool excluido = false;

  String? uid;
  ProdutoModel? fkProduto;

  FavoritoModel({
    this.uid,
    this.fkProduto,
    this.excluido = false,
  });

  FavoritoModel.fromJson(this.docRef, Map<String, dynamic> json)
      : uid = json['uid'] as String?,
        excluido = json['excluido'] ?? false,
        fkProduto = null;

  FavoritoModel.fromDocument(DocumentSnapshot doc)
      : this.fromJson(
          doc.reference,
          doc.data() as Map<String, dynamic>,
        );

  @override
  Map<String, dynamic> toJson({bool fullJson = false}) => {
        'uid': uid,
        'fk_produto': fullJson
            ? fkProduto?.toJson(fullJson: true)
            : referenceFromModel(fkProduto),
        'excluido': excluido,
      };

  static Future<FavoritoModel> get(
    String documentPath, {
    bool full = false,
  }) async {
    final snap =
        await FirebaseFirestore.instance.doc(documentPath).get();

    final data = snap.data() as Map<String, dynamic>;
    final favorito = FavoritoModel.fromJson(snap.reference, data);

    if (full && data['fk_produto'] is DocumentReference) {
      await favorito.loadProduto(data['fk_produto'] as DocumentReference);
    }

    return favorito;
  }

  Future<ProdutoModel> loadProduto(DocumentReference ref) async {
    final snap = await ref.get();

    if (!snap.exists) {
      throw StateError('Produto não encontrado: ${ref.path}');
    }

    fkProduto = ProdutoModel.fromJson(
      ref,
      snap.data() as Map<String, dynamic>,
    );

    return fkProduto!;
  }
}
