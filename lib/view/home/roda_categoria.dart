import 'dart:math';

import 'package:app_eyewear/model/categoria_model.dart';
import 'package:app_eyewear/view/layout.dart';
import 'package:app_eyewear/view/produto/categoria_page.dart';
import 'package:flutter/material.dart';

enum SweypDirection { left, right }

class RodaCategoria extends StatefulWidget {
  const RodaCategoria(this.categorias, {super.key});
  final List<CategoriaModel>? categorias;
  @override
  State<RodaCategoria> createState() => _RodaCategoriaState();
}

class _RodaCategoriaState extends State<RodaCategoria>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  //  Model de itens para ser impresso na roda

  // Controlar o grau de giro por item
  double _startDeg = 0.0;
  double _endDeg = 0.0;

  // Controle do lado que o usuario esta arrastando
  double _dragInitial = 0;
  SweypDirection? _sweypDirection;

  // Controle do item atual
  int _currentItem = 0;

  @override
  void initState() {
    super.initState();

    // Inicia a animacao
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          // Este bloco serve apenas para Sobra
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                spreadRadius: 2,
                offset: Offset(2, 0),
                color: Layout.dark(.3),
              ),
            ],
          ),
        ),

        RotationTransition(
          //Este eh o elemento que realmente eh rotacionado
          turns: Tween(begin: _startDeg, end: _endDeg).animate(_controller),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      CategoriaPage(widget.categorias![_currentItem]),
                ),
              );
            },

            onHorizontalDragStart: (details) {
              _dragInitial = details.globalPosition.dx;
            },
            onHorizontalDragUpdate: (details) {
              _sweypDirection = SweypDirection.right;
              if (details.globalPosition.dx - _dragInitial < 0) {
                _sweypDirection = SweypDirection.left;
              }
            },

            onHorizontalDragEnd: (details) {
              // Aplica animacao dependendo do lado que arrastou
              // Marca a posicao inicial da roda com
              // Ultima posicao que a animacao fez

              _startDeg = _endDeg;

              // Reinicia a animacao
              _controller.reset();

              switch (_sweypDirection) {
                case SweypDirection.left:

                  // Informa a angulo para girar
                  _endDeg -= (1 / widget.categorias!.length);
                  // Troca o indice do item selecionado item do topo

                  _currentItem++;
                  if (_currentItem > widget.categorias!.length - 1) {
                    _currentItem = 0;
                  }
                  break;

                case SweypDirection.right:
                  _endDeg += (1 / widget.categorias!.length);
                  _currentItem--;
                  if (_currentItem < 0) {
                    _currentItem = widget.categorias!.length - 1;
                  }
                  break;
                default:
              }
              _sweypDirection = null;

              // Dispara a animacao

              setState(() {
                _controller.forward();
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Layout.secondaryDark(),
                shape: BoxShape.circle,
              ),
              child: Stack(children: _getCategory()),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _getCategory() {
    List<Widget> result = [];

    result.add(
      ClipRRect(
        //Aqui temos a imagem de fundo da roda
        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width),
        child: Image.asset('assets/images/rodape_app.png', fit: BoxFit.cover),
      ),
    );

    // Define o fator de angulacao de cada item
    // Ou seja, o quanto cada um vai ser angulado
    var angleFactor = (pi * 2) / widget.categorias!.length;
    var angle = angleFactor * -1;

    for (CategoriaModel item in widget.categorias!) {
      // Aplica fator de angulacao
      angle += angleFactor;
      result.add(
        Transform.rotate(
          //Cada um dos Layout.categorias da roda
          angle: angle,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // color: Colors.purple,
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Icon(item.getIcone(), color: Layout.light(), size: 32),
                ),
                Text(
                  item.nome as String,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: Layout.light()),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return result;
  }
}
