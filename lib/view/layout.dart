
import 'package:app_eyewear/controller/user_controller.dart';
import 'package:app_eyewear/view/carrinho/carrinho_page.dart';
import 'package:app_eyewear/view/compras/compras_page.dart';
import 'package:app_eyewear/view/home/home_page.dart';
import 'package:app_eyewear/view/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Layout {
  static Widget render(
    BuildContext context,
    Widget child, {

    Widget? floatingActionButton,
    int? bottomItemSelected,
  }) {

      var user = Provider.of<UserController>(context);
    
  
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/wallpaper_app.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Column(
              children: <Widget>[
                Container(
                  color: Layout.secondary(),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsetsGeometry.fromLTRB(30, 20, 10, 20),
                        child: FaIcon(
                          FontAwesomeIcons.userGear,
                          
                          color: Layout.light(),
                          size: 24,
                        ),
                        
                      ),
                      Expanded(child: Text('Tiago Couto', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Layout.light(),fontSize:18 ,fontStyle: FontStyle.italic),)),
                      
                      Padding(padding: EdgeInsetsGeometry.only(right: 30),
                      child: GestureDetector(onTap: () =>  Navigator.of(context).pushNamed(CarrinhoPage.tag), child: Row(children: <Widget>[
                        FaIcon(FontAwesomeIcons.bagShopping, color: Layout.primaryLight(), size: 24,)
                      ],),)),
                      
               
                    ],
                  ),
                ),
                Expanded(child: child),
              ],
            ),

            // Positioned.fill(child: child),
          ],
        ),
      ),
      floatingActionButton: floatingActionButton,
      backgroundColor: Layout.secondary(),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.umbrellaBeach, size: 30),
            label: 'inicio',
          ),
          BottomNavigationBarItem(
            label: 'Compras',
            icon: FaIcon(FontAwesomeIcons.solidStar, size: 30),
          ),
          BottomNavigationBarItem(
            label: 'Favoritos',
            icon: FaIcon(FontAwesomeIcons.solidHeart, size: 30),
          ),
          BottomNavigationBarItem(
            label: 'Sair',
            icon: FaIcon(FontAwesomeIcons.rightFromBracket, size: 30),
          ),
        ],
        currentIndex: bottomItemSelected ?? 0,
        selectedItemColor: (bottomItemSelected == null)
            ? Layout.dark(.3)
            : Layout.primaryLight(),
        unselectedItemColor: Layout.dark(.3),
        backgroundColor: Layout.light(),
        type: BottomNavigationBarType.fixed,
        onTap: (int i) {
          switch(i) {
            case 0:
            Navigator.of(context).pushNamed(HomePage.tag);
            break;
            case 1:
            Navigator.of(context).pushNamed(ComprasPage.tag);
            break;
            case 3:
            // Desloga Usuario
            user.signOut();
            // Navega para pagina de login
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.of(context).popAndPushNamed(LoginPage.tag);
            break;
          }
        },
      ),
    );
  }

    static List<Map<String, dynamic>> categorias = const [
    {'id': 1, 'icon': Icons.favorite, 'text': 'Estilo'},
    {'id': 2, 'icon': Icons.filter_drama, 'text': 'Teen'},
    {'id': 3, 'icon': Icons.flight, 'text': 'Viagem'},
    {'id': 4, 'icon': Icons.store_mall_directory, 'text': 'Trabalho'},
    {'id': 5, 'icon': Icons.style, 'text': 'Casual'},
    {'id': 6, 'icon': Icons.supervised_user_circle, 'text': 'Excutivo'},
    {'id': 7, 'icon': Icons.switch_video, 'text': 'Esporte'},
    {'id': 8, 'icon': Icons.thumb_up, 'text': 'Classico'},
  ];

    static Map<String ,dynamic > cateoriaPorId (int id) {
      return Layout.categorias.firstWhere((e) =>  e['id'] == id);
  }

  static Color primary([double opacity = 1]) =>
      Color(0xff195738).withValues(alpha: opacity);
  static Color primaryLight([double opacity = 1]) =>
      Color(0xff007d40).withValues(alpha: opacity);
  static Color primaryDark([double opacity = 1]) =>
      Color(0xff123D27).withValues(alpha: opacity);

  static Color secondary([double opacity = 1]) =>
      Color(0xffddcc199).withValues(alpha: opacity);
  static Color secondaryLight([double opacity = 1]) =>
      Color(0xffE0CF9D).withValues(alpha: opacity);

  static Color secondaryDark([double opacity = 1]) =>
      Color(0xffFFCE9150).withValues(alpha: opacity);
  static Color secondaryHighLight([double opacity = 1]) =>
      Color(0xffFDAC25).withValues(alpha: opacity);

  static Color light([double opacity = 1]) =>
      Color(0xffF0ECE1).withValues(alpha: opacity);
  static Color dark([double opacity = 1]) =>
      Color(0xff333333).withValues(alpha: opacity);

}