import 'package:app_eyewear/model/model_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProdutoModel implements ModelInterface {
  @override
  final DocumentReference  docRef;

  @override
  bool excluido =false;

  final String? titulo;
  final String? chamada;
  final String? detalhe;
  final double? preco;
  final DocumentReference? fkCategoria;

  ProdutoModel({
    required this.docRef,
    this.titulo,
    this.chamada,
    this.detalhe,
    this.preco,
    this.fkCategoria,
    this.excluido = false,
  });

  ProdutoModel.fromJson(this.docRef, Map<String, dynamic> json)
    : titulo = json['titulo'] as String?,
      chamada = json['chamada'] as String?,
      detalhe = json['detalhe'] as String?,
      preco = (json['preco'] as num?)?.toDouble(),
      fkCategoria = json['fk_categoria'] as DocumentReference?,
      excluido = json['excluido'] ?? false;
}
