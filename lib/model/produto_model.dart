import 'package:app_eyewear/model/categoria_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'abstract_model.dart';

class ProdutoModel extends AbstractModel {
  @override
  String get path => 'produto';

  @override
  DocumentReference? docRef;
  DocumentReference? fkCategoriaRef;
  CategoriaModel? fkCategoria;

  @override
  bool excluido = false;

  final String? titulo;
  final String? chamada;
  final String? detalhe;
  final double? preco;
  final String? imagem;
  final bool? destaque;

  ProdutoModel({
    this.docRef,
    this.imagem,
    this.destaque,
    this.fkCategoriaRef,
    this.fkCategoria,
    this.titulo,
    this.chamada,
    this.detalhe,
    this.preco,
    this.excluido = false,
  });

  ProdutoModel.fromJson(this.docRef, Map<String, dynamic> json)
    : titulo = json['titulo'],
      chamada = json['chamada'],
      detalhe = json['detalhe'],
      preco = (json['preco'] as num?)?.toDouble(),
      imagem = json['imagem'],
      destaque = json['destaque'],
      fkCategoriaRef = json['fk_categoria'],
      excluido = json['excluido'] ?? false;

  @override
  Map<String, dynamic> toJson({bool fullJson = false}) => {
    'titulo': titulo,
    'chamada': chamada,
    'detalhe': detalhe,
    'preco': preco,
    'fk_categoria': fullJson? fkCategoria?.docRef : fkCategoriaRef,
    'excluido': excluido,
    'imagem': imagem,
    'destaque': destaque,
  };

  static Future<ProdutoModel> get(String documentPath, {full = false}) async {
    var item = await FirebaseFirestore.instance.doc(documentPath).get();
    return ProdutoModel.fromJson(
      item.reference,
      item.data() as Map<String, dynamic>,
    );
  }

  @override
  String toString() => 'produto/${docRef!.id}';
}
