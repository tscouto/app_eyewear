import 'package:app_eyewear/constants.dart';
import 'package:app_eyewear/controller/carrinho/carrinho_item_store.dart';
import 'package:app_eyewear/controller/carrinho/carrinho_store.dart';
import 'package:app_eyewear/function/sums_dates/function.dart';
import 'package:app_eyewear/model/compra_model.dart';
import 'package:app_eyewear/model/endereco_model.dart';
import 'package:app_eyewear/model/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class FinalizaCompraController {
  CarrinhoStore carrinho;
  String uid;
  EnderecoModel? _enderecoModel;

  FinalizaCompraController({required this.carrinho, required this.uid})
      : assert(carrinho != null),
        assert(uid != null);

  // Validação da compra
  Future<bool> isValid() async {
    bool result = true;

    if (carrinho.items.isEmpty) {
      result = false;
    }

    if (carrinho.frete == null) {
      result = false;
    }

    // Buscar endereço do usuário
    var enderecoSnap = await FirebaseFirestore.instance
        .collection('endereco')
        .where('uid', isEqualTo: uid)
        .limit(1)
        .get();

    if (enderecoSnap.docs.isEmpty) {
      result = false;
    } else {
      _enderecoModel = EnderecoModel.fromDocument(enderecoSnap.docs.first);
      if (_enderecoModel!.cep == null || _enderecoModel!.cep!.isEmpty) {
        result = false;
      }
    }

    return result;
  }

  // Salvar compra
  Future<DocumentReference> save(TipoPagto tipoPagto) async {
    // Garantir que o endereço está preenchido
    if (_enderecoModel == null) {
      var enderecoSnap = await FirebaseFirestore.instance
          .collection('endereco')
          .where('uid', isEqualTo: uid)
          .limit(1)
          .get();

      if (enderecoSnap.docs.isEmpty) {
        throw Exception('Usuário não possui endereço cadastrado');
      }

      _enderecoModel = EnderecoModel.fromDocument(enderecoSnap.docs.first);
    }

    // Buscar o último sequence
    var seq = await FirebaseFirestore.instance
        .collection('compra')
        .limit(1)
        .orderBy('sequence', descending: true)
        .get();

    var sequence = 1;
    if (seq.docs.isNotEmpty) {
      sequence = (seq.docs.first.data()['sequence'] ?? 0) + 1;
    }

    // Criar compra
    var compra = CompraModel(
      sequence: sequence,
      uid: uid,
      data: Timestamp.now(),
      status: statusAguardandoPagamento,
      tipoFrete: carrinho.frete!.nome,
      prazoFrete:carrinho.frete!.prazo ,
      tipoPagamento: tipoPagto.value,
      valorFrete: carrinho.valorFrete,
      valorItens: carrinho.valorItems,
      valorTotal: carrinho.valorTotal,
      cep: _enderecoModel!.cep,
      rua: _enderecoModel!.rua,
      numero: _enderecoModel!.numero,
      complemento: _enderecoModel!.complemento,
      bairro: _enderecoModel!.bairro,
      cidade: _enderecoModel!.cidade,
      estado: _enderecoModel!.estado,
    );

    await compra.insert();

    // Salvar itens da compra
    for (var item in carrinho.items) {
      var itemModel = ItemModel(
        titulo: item.produto.titulo,
        quantidade: item.quantidade,
        valorUnitario: item.produto.preco,
        valorTotal: item.valorItem,
        cor: item.cor,
        fkCompra: compra,
        fkProduto: item.produto,
      );
      await itemModel.insert();
    }

    return compra.docRef!;
  }
}
