import 'package:app_eyewear/view/layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProdutoPage extends StatefulWidget {
  const ProdutoPage(this.id, {super.key});
  static String tag = '/produto-page';
  final int id;

  @override
  State<ProdutoPage> createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  int currentPic = 0;

  @override
  Widget build(BuildContext context) {
    int currentPic = 0;
    var sController = ScrollController();
    var listViewItemWidth = MediaQuery.of(context).size.width - 40;

    var content = Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.width / 2,
            child: Stack(
              children: [
                ListView.builder(
                  controller: sController,
                  scrollDirection: Axis.horizontal,
                  physics: PageScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int i) {
                    return Container(
                      width: listViewItemWidth,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                        child: Image.asset(
                          'assets/images/produtos/prod-${i + 1}.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  width: listViewItemWidth,
                  padding: const EdgeInsets.only(top: 10),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[300],
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10),
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.solidHeart,
                        color: Layout.light(),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: listViewItemWidth,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        sController.animateTo(
                          (currentPic - 1) * listViewItemWidth,
                          duration: Duration(microseconds: 700),
                          curve: Curves.ease,
                        );
                        currentPic--;
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.chevronLeft,
                        color: Layout.light(),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: listViewItemWidth,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        sController.animateTo(
                          (currentPic + 1) * listViewItemWidth,
                          duration: Duration(microseconds: 700),
                          curve: Curves.ease,
                        );
                        currentPic++;
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.chevronRight,
                        color: Layout.light(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Layout.light(),
              height: 100,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width - 60) * .65,
                        child: Text(
                          'R\$ 150,00',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(color: Layout.primaryDark()),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Chip(label: Text('Vermelho')),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Chip(label: Text('Preto')),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Chip(label: Text('Azul')),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Text(
                          'Detalhes',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(color: Layout.primaryDark()),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'A populacao ela precisa da Zona Fraca de Mnaua, porque na Zona Franca de Manaus, nao e uma zona de exportacao, e uma zona para o Brasil. Portanto ela tem um objetivo, ela evita a desmatamamento que e altamente lucrativo, Deeeubar arvores da natureza e uma lucrativo',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Layout.primary(),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Center(
              child: Text(
                'Comprar',
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
    return Layout.render(context, content);
  }
}
