import 'package:app_eyewear/model/abstract_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompraModel extends AbstractModel {
  @override
  String get path => 'compra';

  @override
  DocumentReference? docRef;

  @override
  bool excluido;

  int? sequence;
  String? uid; // Id do usuario no Firebase
  Timestamp? data;
  String? status;
  String? tipoFrete;
  int? prazoFrete;
  String? tipoPagamento;
  String? comprovante;

  double? valorFrete;
  double? valorItens;
  double? valorTotal;

  int? cep;
  String? rua;
  int? numero;
  String? complemento;
  String? bairro;
  String? cidade;
  String? estado;

  CompraModel({
    this.sequence,
    this.uid,
    this.data,
    this.status,
    this.tipoFrete,
    this.prazoFrete,
    this.tipoPagamento,
    this.comprovante,
    this.valorFrete,
    this.valorItens,
    this.valorTotal,
    this.cep,
    this.rua,
    this.numero,
    this.complemento,
    this.bairro,
    this.cidade,
    this.estado,
    this.excluido = false,
  });

  CompraModel.fromJson(this.docRef, Map<String, dynamic> json)
    : sequence = json['sequence'],
      uid = json['uid'],
      data = json['data'],
      status = json['status'],
      tipoFrete = json['tipo_frete'],
      prazoFrete = json['prazo_frete'],
      tipoPagamento = json['tipo_pagamento'],
      comprovante = json['comprovante'],
      valorFrete = double.parse(json['valor_frete'].toString()),
      valorItens = double.parse(json['valor_itens'].toString()),
      valorTotal = double.parse(json['valor_total'].toString()),
      cep = json['cep'],
      rua = json['rua'],
      numero = json['numero'],
      complemento = json['complemento'],
      bairro = json['bairro'],
      cidade = json['cidade'],
      estado = json['estado'],
      excluido = json['excluido'];

  CompraModel.fromDocument(DocumentSnapshot doc)
    : this.fromJson(doc.reference, doc.data() as Map<String, dynamic>);

  @override
  Map<String, dynamic> toJson({bool fullJson = false}) => {
    'sequence': sequence,
    'uid': uid,
    'data': data,
    'status': status,
    'tipo_frete': tipoFrete,
    'prazo_frete': prazoFrete,
    'tipo_pagamento': tipoPagamento,
    'comprovante': comprovante,
    'valor_frete': valorFrete,
    'valor_itens': valorItens,
    'valor_total': valorTotal,
    'cep': cep,
    'rua': rua,
    'numero': numero,
    'complemento': complemento,
    'bairro': bairro,
    'cidade': cidade,
    'estado': estado,
    'excluido': excluido,
  };

  static Future<CompraModel> get(String documentPath, {full = false}) async {
    var item = await FirebaseFirestore.instance.doc(documentPath).get();
    return CompraModel.fromJson(
      item.reference,
      item.data() as Map<String, dynamic>,
    );
  }
}
