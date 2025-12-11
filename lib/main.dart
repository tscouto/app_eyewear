import 'package:app_eyewear/view/carrinho/carrinho_page.dart';
import 'package:app_eyewear/view/compras/compras_page.dart';
import 'package:app_eyewear/view/favoritos/favoritos_page.dart';
import 'package:app_eyewear/view/home/home_page.dart';
import 'package:app_eyewear/view/layout.dart';
import 'package:app_eyewear/view/login/cadastro_page.dart';
import 'package:app_eyewear/view/login/login_page.dart';
import 'package:app_eyewear/view/login/login_recuperar_page.dart';
import 'package:app_eyewear/view/perfil/perfil_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'JosefinSans',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            shadows: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 2,
                color: Layout.dark(.3),
                offset: Offset(1, 2),
              ),
            ],
          ),
          titleSmall: TextStyle(
            shadows: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 2,
                color: Layout.dark(.3),
                offset: Offset(1, 2),
              ),
            ],
          ),
        ),
      ),
      initialRoute: CarrinhoPage.tag,
      routes: {
        HomePage.tag: (context) => HomePage(),
        LoginPage.tag: (context) => LoginPage(),
        LoginRecuperarPage.tag: (context) => LoginRecuperarPage(),
        CadastroPage.tag: (context) => CadastroPage(),
        FavoritosPage.tag: (context) => FavoritosPage(),
        PerfilPage.tag: (context) => PerfilPage(),
        CarrinhoPage.tag: (context) => CarrinhoPage(),
        ComprasPage.tag: (context) => ComprasPage(),
      },
    );
  }
}
