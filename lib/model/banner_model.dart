import 'package:app_eyewear/model/abstract_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel extends AbstractModel {
  @override
  String get path => 'banner';

  @override
  DocumentReference? docRef;

  @override
  bool excluido;

  Timestamp? dataInicial;
  Timestamp? dataFinal;
  String? urlImagem;

  BannerModel({
    this.dataInicial,
    this.dataFinal,
    this.urlImagem,
    this.excluido = false,
  });

  BannerModel.fromJson(this.docRef, Map<String, dynamic> json)
    : dataInicial = json['data_inicial'],
      dataFinal = json['data_final'],
      urlImagem = json['url_imagem'],
      excluido = json['excluido'];

  @override
  Map<String, dynamic> toJson({bool fullJson = false}) => {
    'data_inicial': dataInicial,
    'data_final': dataFinal,
    'url_imagem': urlImagem,
    'excluido': excluido,
  };
  static Future<BannerModel> get(String documentPath, {full = false}) async {
    var item = await FirebaseFirestore.instance.doc(documentPath).get();
    return BannerModel.fromJson(
      item.reference,
      item.data() as Map<String, dynamic>,
    );
  }
}
