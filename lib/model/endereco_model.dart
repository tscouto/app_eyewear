import 'package:app_eyewear/model/abstract_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EnderecoModel extends AbstractModel {
  @override
  String get path => 'endereco';

  @override
  DocumentReference? docRef;

  @override
  bool excluido;

  String uid; // Id do usuario no Firebase
  String cep;
  String rua;
  String numero;
  String complemento;
  String bairro;
  String cidade;
  String estado;

  EnderecoModel({
    required this.uid,
    this.cep = '',
    this.rua = '',
    this.numero = '',
    this.complemento = '',
    this.bairro = '',
    this.cidade = '',
    this.estado = '',
    this.excluido = false,
  });

  EnderecoModel.fromJson(this.docRef, Map<String, dynamic> json)
    : uid = (json['uid'] ?? '') as String,
      cep = (json['cep'] ?? '') as String,
      rua = (json['rua'] ?? '') as String,
      numero = (json['numero'] ?? '') as String,
      complemento = (json['complemento'] ?? '') as String,
      bairro = (json['bairro'] ?? '') as String,
      cidade = (json['cidade'] ?? '') as String,
      estado = (json['estado'] ?? '') as String,
      excluido = (json['excluido'] ?? false) as bool;

  EnderecoModel.fromDocument(DocumentSnapshot doc)
    : this.fromJson(
        doc.reference,
        (doc.data() as Map<String, dynamic>? ?? <String, dynamic>{}),
      );

  @override
  Map<String, dynamic> toJson({bool fullJson = false}) => {
    'uid': uid,
    'cep': cep,
    'rua': rua,
    'numero': numero,
    'complemento': complemento,
    'bairro': bairro,
    'estado': estado,
    'cidade': cidade,
    'excluido': excluido,
  };

  static Future<EnderecoModel> get(String documentPath, {full = false}) async {
    var item = await FirebaseFirestore.instance.doc(documentPath).get();
    final data = (item.data as Map<String, dynamic>? ?? <String, dynamic>{});
    return EnderecoModel.fromJson(item.reference, data);
  }
}
