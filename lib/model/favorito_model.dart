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

  String uid;
  DocumentReference fkProduto; // ✅ CORRETO

  ProdutoModel? produto; // opcional (lazy load)

  FavoritoModel({
    required this.uid,
    required this.fkProduto,
    this.excluido = false,
    this.produto,
  });

  FavoritoModel.fromJson(DocumentReference ref, Map<String, dynamic> json)
      : docRef = ref,
        uid = json['uid'],
        fkProduto = json['fk_produto'],
        excluido = json['excluido'] ?? false;

  FavoritoModel.fromDocument(DocumentSnapshot doc)
      : this.fromJson(
          doc.reference,
          doc.data() as Map<String, dynamic>,
        );

  @override
  Map<String, dynamic> toJson({bool fullJson = false}) => {
        'uid': uid,
        'fk_produto': fkProduto, // 🔥 SEMPRE reference
        'excluido': excluido,
      };

  Future<void> insert() async {
    await FirebaseFirestore.instance.collection(path).add(toJson());
  }

  Future<void> update() async {
    await docRef!.update(toJson());
  }

  /// Lazy load opcional
  Future<ProdutoModel> loadProduto() async {
    final snap = await fkProduto.get();

    produto = ProdutoModel.fromJson(
      fkProduto,
      snap.data() as Map<String, dynamic>,
    );

    return produto!;
  }
}