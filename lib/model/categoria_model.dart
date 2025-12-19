import 'package:app_eyewear/model/model_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class CategoriaModel implements ModelInterface {
     @override
  DocumentReference docRef;

  @override
  bool excluido;

 final String? nome;
  final String? icone;

    CategoriaModel({
      required this.docRef,
      this.nome,
      this.icone,
      this.excluido = false
    });
}