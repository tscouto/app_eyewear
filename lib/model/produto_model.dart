import 'package:cloud_firestore/cloud_firestore.dart';
import 'abstract_model.dart';

class ProdutoModel extends AbstractModel {
  @override
  String get path => 'produto';

  @override
  final DocumentReference docRef;

  @override
  bool excluido = false;

  final String? titulo;
  final String? chamada;
  final String? detalhe;
  final double? preco;

  ProdutoModel({
    required this.docRef,
    this.titulo,
    this.chamada,
    this.detalhe,
    this.preco,
    this.excluido = false,
  });

  ProdutoModel.fromJson(this.docRef, Map<String, dynamic> json)
    : titulo = json['titulo'] as String?,
      chamada = json['chamada'] as String?,
      detalhe = json['detalhe'] as String?,
      preco = (json['preco'] as num?)?.toDouble(),
      excluido = json['excluido'] ?? false;

  @override
  Map<String, dynamic> toJson({bool fullJson = false}) => {
    'titulo': titulo,
    'chamada': chamada,
    'detalhe': detalhe,
    'preco': preco,
    'excluido': excluido,
  };

  static Future<ProdutoModel> get(String documentPath, {full = false}) async {
    var item = await FirebaseFirestore.instance.doc(documentPath).get();
    return ProdutoModel.fromJson(
      item.reference,
      item.data() as Map<String, dynamic>,
    );
  }

  @override
  String toString() => 'produto/${docRef.id}';
}
