import 'package:app_eyewear/view/layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CarrinhoPage extends StatefulWidget {
  const CarrinhoPage({super.key});

  static String tag = '/carrinho';

  @override
  State<CarrinhoPage> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  bool temFrete = true;

  @override
  Widget build(BuildContext context) {
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
        Expanded(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (BuildContext context, int i) {
              return Card(
                margin: i == 0
                    ? const EdgeInsets.fromLTRB(20, 0, 20, 0)
                    : const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
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
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Oculos lidao'),
                                  Text(
                                    'Pensa num oculos legal',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
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
                                  onTap: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () {},
                            icon: Icon(FontAwesomeIcons.caretLeft),
                          ),
                          Text('1'),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(FontAwesomeIcons.caretRight),
                          ),
                          Text('R\$ 15'),
                          Expanded(child: SizedBox()),
                          Chip(label: Text('Vermelho')),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Layout.light(), Layout.light(.6)],
            ),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(70) ),
          ),
          margin: const EdgeInsets.only(top: 10,left: 10),
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 100,
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
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
                          FaIcon(
                            FontAwesomeIcons.solidTruck,
                            color: Layout.primaryDark(),
                          ),
                          (temFrete)
                              ? Text('PAC', textAlign: TextAlign.center)
                              : Text(
                                  'Selecione',
                                  style: TextStyle(color: Colors.red),
                                  textAlign: TextAlign.center,
                                ),
                        ],
                      ),
                    ),
                    temFrete
                        ? Text('Prazo: 2 dias', textAlign: TextAlign.center)
                        : SizedBox(),
                  ],
                ),
              ),
              SizedBox(width: 40),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text('15 produtos'),
                                Text('Frete:'),
                                SizedBox(height: 10),
                                Text('Total:', style: TextStyle(fontSize: 18)),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('R\$ 100,00'),
                              Text('R\$ 50,00'),
                              SizedBox(height: 10),
                              Text(
                                'R\$ 150,00',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text('Finalizar copra'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Layout.primaryDark(.3),
                          disabledBackgroundColor: Layout.light(),
                        ),
                        onPressed: temFrete ? () {} : null,
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
}
