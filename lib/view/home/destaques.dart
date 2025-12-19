import 'package:app_eyewear/view/layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeDestaques extends StatelessWidget {
  const HomeDestaques({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      physics: PageScrollPhysics(),
      children: List.generate(3, (int i) {
        return Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            color: Layout.secondary(0.9),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/produtos/prod-${i + 1}.jpg',
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 40,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.red[300],
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(10),
                            ),
                            child: FaIcon(
                              (i.isEven)
                                  ? FontAwesomeIcons.heart
                                  : FontAwesomeIcons.solidHeart,
                              color: Layout.light(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Oculos do Reinaldo',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: Layout.dark()),
                    ),
                    Text(
                      'Reinaldo Jeanequine',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Layout.secondaryDark(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'R\$ 568,70',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Layout.primary(),
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
