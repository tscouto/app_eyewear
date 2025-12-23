import 'package:app_eyewear/model/produto_model.dart';

class ProdutoDetalheData {
  final ProdutoModel produto;
  final List<String> imagens;
  final List<String> cores;

  ProdutoDetalheData({
    required this.produto,
    required this.imagens,
    required this.cores,
  });
}