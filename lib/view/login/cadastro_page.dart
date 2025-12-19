import 'package:app_eyewear/controller/user_controller.dart';

import 'package:app_eyewear/view/layout.dart';
import 'package:app_eyewear/view/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// class User {
//   late String nome;
//   late String email;
//   late String senha;

//   @override
//   String toString() {
//     return 'Nome: $nome | Email: $email | Senha: $senha';
//   }
// }

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  static String tag = '/cadastro-page';

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _senha = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  final Map<String, dynamic> _data = {};
  // final User user = User();

  @override
  Widget build(BuildContext context) {
    var userController = Provider.of<UserController>(context);
    return Scaffold(
      key: _scaffold,
      body: Form(
        key: _form,
        child: Stack(
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
                            BoxShadow(
                              blurRadius: 15,
                              spreadRadius: 2,
                              color: Layout.dark(.4),
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Nome',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Layout.primary(),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo obrigatorio';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _data['nome'] = value;
                                // user.nome = value as String;
                              },
                            ),
                            SizedBox(height: 20),
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
                                  return 'Campo obrigatorio';
                                } else if (!value.contains('@')) {
                                  return 'Preencha com um email valido';
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
                              controller: _senha,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo obrigatorio';
                                } else if (value != _senha.text) {
                                  return 'As senhas nao sao iguais';
                                } else if (value.length < 6) {
                                  return 'Pelo menos 6 caracteres';
                                }
                                return null;
                              },

                              onSaved: (value) {
                                _data['senha'] = value;
                                // user.senha = value as String;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Confirmar Senha',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Layout.primary(),
                                  ),
                                ),
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo obrigatorio';
                                } else if (value != _senha.text) {
                                  return 'As senhas nao sao iguais';
                                } else if (value.length < 6) {
                                  return 'Pelo menos 6 caracteres';
                                }
                                return null;
                              },
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
                                  if (!_form.currentState!.validate()) return;

                                  _form.currentState!.save();

                                  String? error = await userController
                                      .criarContaPorEmailSenha(
                                        _data['nome'],
                                        _data['email'],
                                        _data['senha'],
                                      );

                                  if (error != null) {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(error)),
                                    );
                                    return;
                                  }

                                  
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).popUntil((route) => route.isFirst);
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pushReplacementNamed(
                                    LoginPage.tag,
                                    arguments:
                                        'Conta criada com sucesso! Verifique seu email.',
                                  );
                                },

                                child: Text(
                                  'Criar conta',
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
                              Navigator.of(context).pushNamed(LoginPage.tag);
                            },
                            child: Text('Fazer login'),
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
      ),
      backgroundColor: Layout.secondary(),
    );
  }

  criarConta(BuildContext context) async {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }
}
