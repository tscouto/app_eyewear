import 'package:app_eyewear/view/home/home_page.dart';
import 'package:app_eyewear/view/layout.dart';
import 'package:app_eyewear/view/login/cadastro_page.dart';
import 'package:app_eyewear/view/login/login_recuperar_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static String tag = '/login-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/wallpaper_app.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 100,
                  left: 40,
                  right: 40,
                  bottom: 20,
                ),
                child: Image.asset('assets/images/logo-sem-fundo.png'),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Layout.light(),
                        boxShadow: [
                          // BoxShadow(
                          //   blurRadius: 15,
                          //   spreadRadius: 2,
                          //   color: Layout.dark(.4),
                          //   offset: Offset(0, 5),
                          // ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Email',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Layout.primary()),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Senha',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Layout.primary()),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(LoginRecuperarPage.tag);
                              },
                              child: Text(
                                'Esqueci minha senha',
                                style: TextStyle(color: Layout.secondaryDark()),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                backgroundColor: Layout.primary(),
                                padding: EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 20,
                                ),
                              ),

                              onPressed: () {
                                Navigator.of(context).popAndPushNamed(HomePage.tag);
                              },
                              child: Text(
                                'Entrar',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Layout.light(),
                                      fontSize: 18,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, right: 20),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(CadastroPage.tag);
                          },
                          child: Text('Não tem uma conta? Cadastre-se'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Layout.secondary(),
    );
  }
}
