import 'package:app_eyewear/constants.dart';
import 'package:app_eyewear/controller/carrinho/carrinho_frete_store.dart';
import 'package:app_eyewear/controller/carrinho/carrinho_store.dart';
import 'package:app_eyewear/controller/users/user_controller.dart';

import 'package:app_eyewear/function/correios/simulador_frete.dart';
import 'package:app_eyewear/function/sums_dates/function.dart';
import 'package:app_eyewear/model/endereco_model.dart';
import 'package:app_eyewear/view/carrinho/finaliza_page.dart';
import 'package:app_eyewear/view/layout.dart';
import 'package:app_eyewear/view/perfil/perfil_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CarrinhoPage extends StatefulWidget {
  CarrinhoPage({super.key});

  static String tag = '/carrinho';

  @override
  State<CarrinhoPage> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  @override
  Widget build(BuildContext context) {
    var _carrinho = Provider.of<CarrinhoStore>(context);

    var content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 10),
          child: Text(
            'Carrinho',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Layout.primaryDark()),
          ),
        ),
        Observer(
          builder: (context) {
            return Expanded(
              child: _carrinho.items.isNotEmpty
                  ? _getListaProdutos(_carrinho)
                  : Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Nenhum produto ainda'),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(
                                context,
                              ).popUntil((route) => route.isFirst);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[900],
                              textStyle: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(color: Layout.light()),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: Text(
                              'Ver produtos',
                              style: TextStyle(color: Layout.light()),
                            ),
                          ),
                        ],
                      ),
                    ),
            );
          },
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Layout.light(), Layout.light(.6)],
            ),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(70)),
          ),
          margin: const EdgeInsets.only(top: 10, left: 10),
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Observer(
                builder: (context) {
                  return Container(
                    width: 100,
                    height: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            _selecionaFrete(context, _carrinho);
                          },
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Layout.dark(.1),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                (_carrinho.frete != null)
                                    ? FaIcon(
                                        getFreteIcon(_carrinho.frete!.nome),
                                        color: Layout.primaryDark(),
                                      )
                                    : FaIcon(
                                        FontAwesomeIcons.solidTruck,
                                        color: Layout.primaryDark(),
                                      ),

                                (_carrinho.frete != null)
                                    ? Text(
                                        _carrinho.frete!.nome,
                                        textAlign: TextAlign.center,
                                      )
                                    : Text(
                                        'Selecione',
                                        style: TextStyle(color: Colors.red),
                                        textAlign: TextAlign.center,
                                      ),
                              ],
                            ),
                          ),
                        ),
                        (_carrinho.frete != null)
                            ? Text(
                                'Prazo: ${_carrinho.frete!.prazo} dia(s)',
                                textAlign: TextAlign.center,
                              )
                            : SizedBox(),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(width: 40),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Observer(
                                  builder: (context) => Text(
                                    '${_carrinho.items.length} produtos',
                                  ),
                                ),
                                Text('Frete:'),
                                SizedBox(height: 10),
                                Text('Total: ', style: TextStyle(fontSize: 18)),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 10),

                          child: Observer(
                            builder: (context) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'R\$ ${_carrinho.valorItems.toBRL()}',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  Text(
                                    'R\$ ${_carrinho.valorFrete.toBRL()} ',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'R\$ ${_carrinho.valorTotal.toBRL()}',

                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    SizedBox(
                      width: double.infinity,
                      child: Observer(
                        builder: (context) {
                          return ElevatedButton(
                            onPressed: (_carrinho.frete != null)
                                ? () {
                                    Navigator.of(
                                      context,
                                    ).pushNamed(FinalizaPage.tag);
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Layout.primary(),
                              disabledBackgroundColor: Layout.light(),
                              foregroundColor: _getTextColor(
                                Layout.primary(.2),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: Text('Continuar'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(color: Layout.dark(.3), height: 1),
      ],
    );
    return Layout.render(context, content);
  }

  Widget _getListaProdutos(CarrinhoStore carrinho) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: carrinho.items.length,
      itemBuilder: (BuildContext context, int i) {
        var item = carrinho.items[i];
        return Card(
          margin: i == 0
              ? const EdgeInsets.fromLTRB(20, 0, 20, 0)
              : const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/produtos/prod-${i + 1}.jpg',
                        width: 50,
                        height: 50,
                      ),
                      //_buildProdutoImagem(item.produto.imagem!),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(item.produto.titulo as String),
                            Text(
                              item.produto.chamada as String,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Layout.dark(.6)),
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Material(
                        color: Colors.red[300],
                        borderRadius: BorderRadius.circular(25),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: InkWell(
                            child: Icon(
                              FontAwesomeIcons.solidTrashCan,
                              size: 18,
                              color: Layout.light(),
                            ),
                            onTap: () {
                              setState(() {
                                carrinho.removeItem(item);
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        setState(() {
                          item.decrement();
                        });
                      },
                      icon: Icon(FontAwesomeIcons.caretLeft),
                    ),
                    Text(item.quantidade.toString()),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          item.increment();
                        });
                      },
                      icon: Icon(FontAwesomeIcons.caretRight),
                    ),
                    Text(item.valorItem.toBRL()),
                    Expanded(child: SizedBox()),
                    Chip(label: Text(item.cor as String)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _selecionaFrete(BuildContext context, CarrinhoStore _carrinho) {
    if (_carrinho.items.isEmpty) {
      return;
    }
    showDialog(
      context: context,
      builder: (context) {
        return FutureBuilder<List<Map<String, dynamic>>>(
          future: _loadFreteValores(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return AlertDialog(
                title: Text('Erro'),
                content: Text(snapshot.error.toString()),
              );
            }

            // if (!snapshot.hasData || snapshot.data!.isEmpty) {
            //   return AlertDialog(
            //     title: Text('Aviso'),
            //     content: Text('Nenhuma opção de frete disponível'),
            //   );
            // }

            return AlertDialog(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              title: Text('Selecione o frete'),
              content: Container(
                width: MediaQuery.of(context).size.width,
                child: SizedBox(
                  width: double.maxFinite,
                  height: 400,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var item = snapshot.data![index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.all(5),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(item['nome'][0]),
                            backgroundColor: Layout.secondary(),
                            foregroundColor: Layout.light(),
                          ),
                          title: Text(item['nome']),
                          subtitle: Text((item['valor'] as double).toBRL()),
                          trailing: Text('${item['prazo']} dias'),
                          onTap: () {
                            _carrinho.frete = CarrinhoFreteStore(
                              nome: item['nome'],
                              valor: item['valor'],
                              prazo: item['prazo'],
                            );
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancelar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  //   Future<List<Map<String, dynamic>>> _loadFreteValores(
  //     BuildContext context,
  //   ) async {
  //     debugPrint('➡️ [FRETE] Iniciando cálculo de frete (SIMULADO)');

  //     final userController = Provider.of<UserController>(context, listen: false);

  //     if (userController.user == null) {
  //       debugPrint('❌ [FRETE] Usuário não autenticado');
  //       return [];
  //     }

  //     debugPrint('👤 [FRETE] UID usuário: ${userController.user!.uid}');

  //     try {
  //       // ===============================
  //       // BUSCA ENDEREÇO
  //       // ===============================
  //       final enderecoSnap = await FirebaseFirestore.instance
  //           .collection('endereco')
  //           .where('uid', isEqualTo: userController.user!.uid)
  //           .limit(1)
  //           .get();

  //       debugPrint(
  //         '📦 [FRETE] Endereços encontrados: ${enderecoSnap.docs.length}',
  //       );

  //       if (enderecoSnap.docs.isEmpty) {
  //         debugPrint('❌ [FRETE] Nenhum endereço cadastrado');
  //         return [];
  //       }

  //       final enderecoModel = EnderecoModel.fromDocument(enderecoSnap.docs.first);

  //       if (enderecoModel.cep.isEmpty) {
  //         debugPrint('❌ [FRETE] CEP vazio');
  //         return [];
  //       }

  //       debugPrint('📍 [FRETE] CEP destino: ${enderecoModel.cep}');

  //       // ===============================
  //       // FRETE SIMULADO
  //       // ===============================
  //       debugPrint('🚚 [FRETE] Calculando fretes simulados...');

  //       final items = await FreteSimuladoService.calcularFrete(
  //         cepOrigem: cepLoja,
  //         cepDestino: enderecoModel.cep,
  //         peso: 1,
  //       );

  //       debugPrint('✅ [FRETE] Total de opções: ${items.length}');
  //       debugPrint('📊 [FRETE] Lista final: $items');

  //       return items;
  //     } catch (e, s) {
  //       debugPrint('💥 [FRETE] ERRO GERAL');
  //       debugPrint('❌ ERRO: $e');
  //       debugPrint('📛 STACK: $s');

  //       return [];
  //     }
  //   }
  // }

  Future<List<Map<String, dynamic>>> _loadFreteValores(
    BuildContext context,
  ) async {
    var _userController = Provider.of<UserController>(context, listen: false);

    var endereco = await FirebaseFirestore.instance
        .collection('endereco')
        .where('uid', isEqualTo: _userController.user!.uid)
        .get();

    var enderecoModel = endereco.docs.isNotEmpty
        ? EnderecoModel.fromDocument(endereco.docs.first)
        : null;
    if (endereco.docs.isEmpty || enderecoModel!.cep.isEmpty) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return PerfilPage(
              snackbarMessage:
                  'Obrigatório completar seu enderenço para continuar',
            );
          },
        ),
      );
    }
    List<Map<String, dynamic>> items = [];

    //Verifica se o cep do usuario esta no range da loja.
    // Essa logica pode nao refletir de fato a realidade, serve ate
    // aqui apenas para lembrar que eu morando no SC não posso receber
    // uma encomenda de SP por motoboy..
    // O certo aqui eh ter uma logica que de fato refglita a realidade
    // junto aos correios

    if (enderecoModel!.cep.substring(0, 2) == cepLoja.substring(0, 2)) {
      items.add({'nome': 'Motoboy', 'valor': 15.00, 'prazo': valorMotoboy});
    } else {
      print(
        'Moto boy não apareceu porque o cep do usuário eh ${enderecoModel.cep} e da loja é $cepLoja',
      );
    }

    var servicos = await FreteSimuladoService.calcularFrete(
      cepOrigem: cepLoja,
      cepDestino: enderecoModel!.cep,
    );

    for (var servico in servicos) {
      if (servico['nome'] != 'Motoboy') {
        items.add({
          'nome': servico['nome'],
          'valor': servico['valor'],
          'prazo': servico['prazo'],
        });
      }
    }

    return items;
  }
}

Color _getTextColor(Color background) {
  // Se a cor for escura, retorna branco; se clara, retorna preto
  return background.computeLuminance() > 0.5 ? Colors.black : Colors.white;
}

IconData getFreteIcon(String nomeFrete) {
  switch (nomeFrete.toLowerCase()) {
    case 'motoboy':
      return FontAwesomeIcons.motorcycle;
    case 'sedex':
      return FontAwesomeIcons.truckFast;
    case 'pac':
      return FontAwesomeIcons.solidTruck;
    default:
      return FontAwesomeIcons.truck; // ícone padrão
  }
}

Widget _buildProdutoImagem(String imagem) {
  // Caminho completo da imagem na pasta produtos
  //final caminhoCompleto = 'images/$imagem';
 final path = 'assets/images/${imagem.replaceAll('//', '/')}';
  return Image.asset(
    path,
    width: 50,
    height: 50,
    fit: BoxFit.cover,
  );
}



