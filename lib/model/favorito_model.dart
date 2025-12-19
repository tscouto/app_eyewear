import 'package:app_eyewear/model/model_interface.dart';
import 'package:app_eyewear/model/produto_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FavoritoModel implements ModelInterface {
  @override
  DocumentReference docRef;

  @override
  bool excluido = false;

  ProdutoModel? fkProduto;
  String? uid;

  FavoritoModel({
    required this.docRef,
    this.fkProduto,
    this.uid,
    this.excluido = false,
  });
  FavoritoModel.fromJson(this.docRef, Map<String, dynamic> json)
    : uid = json['uid'],
      fkProduto = (json['fk_produto'] is ProdutoModel)
          ? json['fk_propduto']
          : null,
      excluido = (json['excluido'] as bool?) ?? false;
}
