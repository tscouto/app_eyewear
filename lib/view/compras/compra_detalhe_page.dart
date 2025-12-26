import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'package:app_eyewear/constants.dart';
import 'package:app_eyewear/controller/compra/compra_detalhe_controller.dart';
import 'package:app_eyewear/function/sums_dates/function.dart';
import 'package:app_eyewear/view/layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CompraDetalhePage extends StatefulWidget {
  CompraDetalhePage(this.compraRef, {super.key});

  static String tag = '/compra-detalhe-page';
  final DocumentReference compraRef;

  @override
  State<CompraDetalhePage> createState() => _CompraDetalhePageState();
}

class _CompraDetalhePageState extends State<CompraDetalhePage> {
  final CompraDetalheController _controller = CompraDetalheController();
  




  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Layout.render(
      context,
      FutureBuilder(
        future: _controller.loadCompraComItens(widget.compraRef),
        builder: (BuildContext context, AsyncSnapshot<CompraDetalheController> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          if (!snapshot.hasData  || _controller.compra == null) {
            return Center(child: CircularProgressIndicator());
          }

          // if (!snapshot.hasData || snapshot.data!.compra.docRef == null) {
          //   return const Center(child: Text('Nenhuma compra'));
          // }

          var data = snapshot.data!;
          var compra = _controller.compra;
          var items = _controller.items;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20, bottom: 0),
                child: Text(
                  'Compra #${data.compra.sequence}',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Layout.light()),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Layout.light(),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Realizada em: ${compra.data?.toFormat()}'),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Text('Status: '),
                          Text(
                            '${compra.status},',
                            style: TextStyle(color: Colors.blue[900]),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text('Total em Itens R\$ ${compra.valorItens?.toBRL()}'),
                      Text(
                        'Frete por ${compra.tipoFrete}: R\$ ${compra.valorFrete?.toBRL()} - ${compra.prazoFrete} dia (s)',
                      ),
                      SizedBox(height: 10),
                      Text('Total: R\$ ${compra.valorTotal?.toBRL()}'),
                      SizedBox(height: 10),
                      (compra.status == statusAguardandoPagamento)
                          ? _renderBotaoPagar()
                          : SizedBox(),
                      Text('Itens:', style: TextStyle(fontSize: 18)),
                      Expanded(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int i) {
                            var item = items[i];
                            var descProduto = '${item.quantidade}';
                            descProduto +=
                                'x R\$${item.valorUnitario?.toBRL()}';
                            descProduto += '\n${item.cor}';

                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: Layout.dark(.1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: ListTile(
                                dense: true,
                                isThreeLine: true,
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  // child: Image.network(
                                  //   'https://picsum.photos/id/${i + 35}/200/200',
                                  // ),
                                  child: Image.asset(
                                    'assets/images/produtos/prod-${i + 1}.jpg',
                                  ),
                                  //   child: item.fkProduto?.imagem != null
                                  //       ? Image.network(
                                  //           item.fkProduto!.imagem!,
                                  //           width: 50,
                                  //           height: 50,
                                  //           fit: BoxFit.cover,
                                  //         )
                                  //       : Icon(Icons.image_not_supported),
                                ),
                                title: Text('${item.titulo}'),
                                subtitle: Text(descProduto),
                                trailing: Text(
                                  'R\$${item.valorTotal?.toBRL()}',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomItemSelected: 1,
    );
  }

  Widget _renderBotaoPagar() {

    var botao;
    if (_isLoading) {
      return  Center(
        child: LinearProgressIndicator( backgroundColor: Colors.blue),
      );
    }
    if (_controller.compra.tipoPagamento == TipoPagto.deposito.value) {
      botao = ElevatedButton(
        onPressed: () {
          _envarComprovante();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Layout.primary(),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        child: const Text(
          'Enviar comprovante',
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    if (_controller.compra.tipoPagamento == TipoPagto.boleto.value) {
      botao = ElevatedButton(
        onPressed: () {
          _envarComprovante();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Layout.primary(),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        child: const Text(
          'Gerar Boleto',
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    if (_controller.compra.tipoPagamento == TipoPagto.cartao.value) {
      botao = ElevatedButton(
        onPressed: () {
          _envarComprovante();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Layout.primary(),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        child: const Text(
          'Pagar com cartão',
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      child: botao,
    );
  }

  void _envarComprovante() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result == null || result.files.single.path == null) {
      return; // usuário cancelou
    }

     setState(() {
      _isLoading = true;
    });

    final pathOriginal = result.files.single.path!;
    final imagemOriginal = File(pathOriginal);

    // 🔹 pega a extensão real do arquivo
    final ext = pathOriginal.split('.').last.toLowerCase();

    // 📁 pasta interna do app
    final dir = await getApplicationDocumentsDirectory();
    final comprovantesDir = Directory('${dir.path}/comprovantes');

    // cria a pasta se não existir
    if (!await comprovantesDir.exists()) {
      await comprovantesDir.create(recursive: true);
    }

    // 📄 nome do arquivo mantendo extensão
    final nomeArquivo = 'compra-${DateTime.now().millisecondsSinceEpoch}.$ext';

    // 📌 caminho completo
    final novoCaminho = '${comprovantesDir.path}/$nomeArquivo';

    // 💾 salva o arquivo
    await imagemOriginal.copy(novoCaminho);

    // 🟢 salva SOMENTE o caminho relativo no banco (boa prática)
    _controller.compra.comprovante = nomeArquivo;
    _controller.compra.status = statusVerificaoPago;
    await _controller.compra.update();

    snackBarSucess('Comprovante de pagamento enviado com sucesso!');

    setState(() {
      _isLoading = false;
    });
    //print('✅ Comprovante salvo em: $novoCaminho');

    //  final result = await FilePicker.platform.pickFiles(
    //   type: FileType.image,
    //   allowMultiple: false,
    // );

    // if (result == null) return;

    // final path = result.files.single.path!;
    // final file = File(path);

    // final ext = path.split('.').last;

    // String filename = 'comprovantes/';
    // filename += '${DateTime.now().microsecondsSinceEpoch}-';
    // filename += 'compra-${_controller.compra.sequence}.$ext';

    // final storageRef = FirebaseStorage.instance.ref().child(filename);

    // final uploadTask = storageRef.putFile(file);

    // await uploadTask;

    // print('Upload finalizado com sucesso');

    //  String ext = file.paths.replaceAll(RegExp(r'.+\.'),'');
    //  String filename = 'comprovantes/';
    //  filename += '${DateTime.now().microsecondsSinceEpoch}-';
    //  filename += 'compra-${_controller.compra.sequence}';
    //  filename += '.${ext}';
  }
}
