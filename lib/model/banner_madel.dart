import 'package:app_eyewear/model/abstract_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BannerMadel extends AbstractModel {
  @override
  String get path => 'banner';

  @override
  DocumentReference? docRef;

  @override
  bool excluido;

  Timestamp? dataInicial;
  Timestamp? dataFinal;
  String? urlImagem;

  BannerMadel({
    this.dataInicial,
    this.dataFinal,
    this.urlImagem,
    this.excluido = false,
  });

  BannerMadel.fromJson(this.docRef, Map<String, dynamic> json)
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
  static Future<BannerMadel> get(String documentPath, {full = false}) async {
    var item = await FirebaseFirestore.instance.doc(documentPath).get();
    return BannerMadel.fromJson(
      item.reference,
      item.data() as Map<String, dynamic>,
    );
  }
}
