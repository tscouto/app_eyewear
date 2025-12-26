import 'package:app_eyewear/controller/users/user_controller.dart';
import 'package:app_eyewear/function/sums_dates/function.dart';
import 'package:app_eyewear/view/layout.dart';
import 'package:app_eyewear/view/login/cadastro_page.dart';
import 'package:app_eyewear/view/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginRecuperarPage extends StatelessWidget {
  LoginRecuperarPage({super.key});

  static String tag = '/login-recuperar-page';
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var userController = Provider.of<UserController>(context);
    return Scaffold(
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
                                hintText: 'Email',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Layout.primary(),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Informe seu email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(
                                    context,
                                  ).pushNamed(LoginPage.tag);
                                },
                                child: Text(
                                  'Fazer login',
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
                                        .recuperarSenhaPorEmail(
                                          _emailController.text.trim(),
                                        );

                                    // ignore: use_build_context_synchronously

                                    snackBarInfo(
                                      (error != null)
                                          ? error
                                          : 'Se o email estiver cadastrado, você receberá um link para redefinir sua senha.',
                                    );
                                  }
                                },
                                child: Text(
                                  'Recuperar Senha',
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
      ),
      backgroundColor: Layout.secondary(),
    );
  }
}
