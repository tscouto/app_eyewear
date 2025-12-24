import 'package:app_eyewear/controller/users/user_controller.dart';
import 'package:app_eyewear/view/home/home_page.dart';
import 'package:app_eyewear/view/layout.dart';
import 'package:app_eyewear/view/login/cadastro_page.dart';
import 'package:app_eyewear/view/login/login_recuperar_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  static String tag = '/login-page';

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final Map<String, dynamic> _data = {};

  @override
  Widget build(BuildContext context) {
    var userController = Provider.of<UserController>(context);
    return Form(
      key: _form,
      child: Scaffold(
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
                                  borderSide: BorderSide(
                                    color: Layout.primary(),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Informe seu email';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _data['email'] = value;
                                // user.email = value as String;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Senha',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Layout.primary(),
                                  ),
                                ),
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Informe a senha';
                                }
                                return null;
                              },

                              onSaved: (value) {
                                _data['senha'] = value;
                                // user.senha = value as String;
                              },
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(
                                    context,
                                  ).pushNamed(LoginRecuperarPage.tag);
                                },
                                child: Text(
                                  'Esqueci minha senha',
                                  style: TextStyle(
                                    color: Layout.secondaryDark(),
                                  ),
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

                                onPressed: () async {
                                  if (_form.currentState!.validate()) {
                                    _form.currentState!.save();

                                    String? error = await userController
                                        .entrarPorEmailSenha(
                                          email: _data['email'],
                                          senha: _data['senha'],
                                        );

                                    if (error != null) {
                                      ScaffoldMessenger.of(
                                        // ignore: use_build_context_synchronously
                                        context,
                                      ).showSnackBar(
                                        SnackBar(content: Text(error)),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        // ignore: use_build_context_synchronously
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Login realizado com sucesso!',
                                          ),
                                         
                                          duration: Duration(seconds: 2),
                                        ),
                                      );

                                      await Future.delayed(
                                        const Duration(seconds: 2),
                                      );
                                      Navigator.of(
                                        // ignore: use_build_context_synchronously
                                        context,
                                      ).popUntil((route) => route.isFirst);
                                       Navigator.of(
                                        // ignore: use_build_context_synchronously
                                        context,
                                      ).pushReplacementNamed(HomePage.tag);
                                    }
                                  }
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
      ),
    );
  }
}
