import 'package:app_eyewear/model/abstract_model.dart';
import 'package:app_eyewear/model/compra_model.dart';
import 'package:app_eyewear/model/produto_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel extends AbstractModel {
  @override
  String get path => 'item';

  @override
  DocumentReference? docRef;

  @override
  bool excluido;

  String? titulo;
  int? quantidade;
  double? preco;
  double? valorUnitario;
  double? valorTotal;
  String? cor;

  DocumentReference? fkCompraRef;
  DocumentReference? fkProdutoRef;

  CompraModel? fkCompra;
  ProdutoModel? fkProduto;

  ItemModel({
    this.titulo,
    this.quantidade,
    this.preco,
    this.valorUnitario,
    this.valorTotal,
    this.cor,
    this.fkCompra,
    this.fkProduto,
    this.excluido = false,
  });

  ItemModel.fromJson(this.docRef, Map<String, dynamic> json)
    : titulo = json['titulo'],
      quantidade = json['quantidade'],
      preco = json['preco'] != null
          ? double.parse(json['preco'].toString())
          : null,
      valorUnitario = json['valor_unitario'] != null
          ? double.parse(json['valor_unitario'].toString())
          : null,
      valorTotal = json['valor_total'] != null
          ? double.parse(json['valor_total'].toString())
          : null,
      cor = json['cor'],
      fkCompraRef = json['fk_compra'],
      fkProdutoRef = json['fk_produto'],
      excluido = json['excluido'] ?? false;

  ItemModel.fromDocument(DocumentSnapshot doc)
    : this.fromJson(doc.reference, doc.data() as Map<String, dynamic>);

  @override
  Map<String, dynamic> toJson({bool fullJson = false}) => {
    'titulo': titulo,
    'quantidade': quantidade,
    'preco': preco,
    'valor_unitario': valorUnitario,
    'valor_total': valorTotal,
    'cor': cor,
    'fk_compra': fullJson ? fkCompra?.toJson() : fkCompraRef,
    'fk_produto': fullJson ? fkProduto?.toJson() : fkProdutoRef,
    'excluido': excluido,
  };

  static Future<ItemModel> get(String documentPath, {bool full = false}) async {
    final snapshot = await FirebaseFirestore.instance.doc(documentPath).get();

    if (!snapshot.exists || snapshot.data() == null) {
      throw Exception('Item não encontrado');
    }

    final result = ItemModel.fromJson(
      snapshot.reference,
      snapshot.data() as Map<String, dynamic>,
    );

    if (full) {
      if (result.fkCompraRef != null) {
        await result.loadCompra();
      }

      if (result.fkProdutoRef != null) {
        await result.loadProduto();
      }
    }

    return result;
  }

  Future<void> loadCompra() async {
    final snap = await fkCompraRef!.get();
    if (!snap.exists || snap.data() == null) return;

    fkCompra = CompraModel.fromJson(
      snap.reference,
      snap.data() as Map<String, dynamic>,
    );
  }

  Future<void> loadProduto() async {
    final snap = await fkProdutoRef!.get();
    if (!snap.exists || snap.data() == null) return;

    fkProduto = ProdutoModel.fromJson(
      snap.reference,
      snap.data() as Map<String, dynamic>,
    );
  }

 
}
