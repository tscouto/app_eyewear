
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
  bool temFrete = false;

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
            itemCount: 5,
            itemBuilder: (BuildContext context, int i) {
              return Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                decoration: BoxDecoration(
                  color: Layout.light(),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(2, 3),
                      color: Layout.dark(.1),
                    ),
                  ],
                ),
                child: SizedBox(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        child: Image.network(
                          'https://picsum.photos/id/${i + 35}/200/300',
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Nome do produto'),
                            SizedBox(height: 5),
                            Text(
                              'Um subtitiulo',
                              style: TextStyle(color: Layout.dark(.6)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('R\$ 125,50'),
                          SizedBox(
                            width: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                GestureDetector(
                                  // ignore: avoid_print
                                  onTap: () => print('Esquerda'),
                                  child: FaIcon(
                                    FontAwesomeIcons.chevronLeft,
                                    size: 16,
                                  ),
                                ),
                                Text('1', style: TextStyle(fontSize: 18)),
                                GestureDetector(
                                  // ignore: avoid_print
                                  onTap: () => print('Direita'),
                                  child: FaIcon(
                                    FontAwesomeIcons.chevronRight,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Layout.light()),
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 80,
                      color: Layout.dark(.1),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      temFrete = true;
                                    });
                                  },
                                  icon: FaIcon(
                                    FontAwesomeIcons.truck,
                                    color: Layout.primary(),
                                  ),
                                ),
                                Text(
                                  'Selecione o Frete',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Layout.primaryDark(),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text('5 Produtos'),
                            Text('Frete:'),
                            SizedBox(height: 10),
                            Text('Total', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('R\$ 150,00'),
                        Text('R\$ 15,00'),
                        SizedBox(height: 10),
                        Text('R\$ 165,80', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: TextButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: Layout.primary(),
                disabledBackgroundColor: Layout.primary(.3),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
              onPressed: temFrete
                  ? () {
                      // ignore: avoid_print
                      print('Finalizar compra');
                    }
                  : null,
              child: Text(
                'Finalizar Compra',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Layout.light(),
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
    return Layout.render(context, content);
  }
}
