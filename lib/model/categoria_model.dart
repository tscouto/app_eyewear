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
    this.excluido = false,
  });
  CategoriaModel.fromJson(this.docRef, Map<String, dynamic> json)
    : nome = json['nome'],
      icone = json['icone'],
      excluido = (json['excluido'] as bool?) ?? false;

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'icone': icone,
    'excluido': excluido,
  };

   static Future<CategoriaModel> get(String documentPath, {full = false}) async {
    var item = await FirebaseFirestore.instance.doc(documentPath).get();
    return CategoriaModel.fromJson(
      item.reference,
      item.data() as Map<String, dynamic>,
    );
  }
  @override
  String toString() {
    return 'categoria/${docRef.id}';
  }
}
