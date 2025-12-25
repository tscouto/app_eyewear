import 'package:app_eyewear/constants.dart';
import 'package:app_eyewear/view/layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';

class FinalizaPage extends StatefulWidget {
  static String tag = '/carrinho-finaliza';
  const FinalizaPage({super.key});

  @override
  State<FinalizaPage> createState() => _FinalizaPageState();
}

class _FinalizaPageState extends State<FinalizaPage> {
  var _loading = false;
  TipoPagto? _tipoPagto;

  @override
  Widget build(BuildContext context) {
    var content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 10),
          child: Text(
            'Método de pagamento',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Layout.primaryDark()),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Card(
                color: Layout.light(),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(FontAwesomeIcons.piggyBank),
                  ),
                  title: Text('Depósito bancário'),
                  subtitle: Text('Libera em até 48 horas'),
                  trailing: Radio(
                    value: TipoPagto.deposito,
                    groupValue: _tipoPagto,
                    activeColor: Colors.blue[900],
                    onChanged: (newVal) {},
                  ),
                  onTap: () {
                    setState(() {
                      if (_loading) return;
                      _tipoPagto = TipoPagto.deposito;
                    });
                  },
                ),
              ),
              Card(
                color: Layout.light(),
                child: ListTile(
                  leading: CircleAvatar(child: Icon(FontAwesomeIcons.ticket)),
                  title: Text('Boleto Bancário'),
                  subtitle: Text('Libera em até 48 horas'),
                  trailing: Radio(
                    value: TipoPagto.boleto,
                    groupValue: _tipoPagto,
                    activeColor: Colors.blue[900],
                    onChanged: (newVal) {},
                  ),
                  onTap: () {
                    setState(() {
                      if (_loading) return;
                      _tipoPagto = TipoPagto.boleto;
                    });
                  },
                ),
              ),
              Card(
                color: Layout.light(),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(FontAwesomeIcons.creditCard),
                  ),
                  title: Text('Cartão de crédito'),
                  subtitle: Text('Liberação imediata'),
                  trailing: Radio(
                    value: TipoPagto.cartao,
                    groupValue: _tipoPagto,
                    activeColor: Colors.blue[900],
                    onChanged: (newVal) {},
                  ),
                  onTap: () {
                    setState(() {
                      if (_loading) return;
                      _tipoPagto = TipoPagto.cartao;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(child: SizedBox()),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              _loading
                  ? LinearProgressIndicator(backgroundColor: Colors.blue[700])
                  : SizedBox(),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: _loading
                      ? null
                      : () {
                          if (_tipoPagto == null) {
                            Get.snackbar(
                              'Atenção!',
                              'Selecione o tipo de pagamento',
                              backgroundColor: Layout.secondaryHighLight(),
                              duration: Duration(seconds: 2),
                            );
                            return;
                          }
                          setState(() {
                            _loading = true;
                          });
                        },
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(color: Layout.light()),
                    backgroundColor: Colors.blue[900],
                    disabledBackgroundColor: Colors.blue[700],
                    disabledForegroundColor: Layout.light(.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),

                  child: Text(
                    _loading ? 'Quase seu..' : 'Finalizar compra',
                    style: TextStyle(color: Layout.light()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
    return Layout.render(context, content);
  }
}
