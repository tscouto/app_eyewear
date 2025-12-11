import 'package:app_eyewear/view/home/destaques.dart';
import 'package:app_eyewear/view/home/promo_banner.dart';
import 'package:app_eyewear/view/home/roda_categoria.dart';
import 'package:app_eyewear/view/layout.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static String tag = '/home-page';

  @override
  Widget build(BuildContext context) {
    var content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: PromoBanner(),
        ),
        SizedBox(height: 20),
        Expanded(
          flex: 2,
          child: HomeDestaques(),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            'Categorias',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Layout.light()),
          ),
        ),
        Container(
          height: 90,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: RodaCategoria(),
          ),
        ),
      ],
    );

    return Layout.render(context, content, bottomItemSelected: 0);
  }
}
