import 'package:app_eyewear/controller/user_controller.dart';
import 'package:app_eyewear/view/home/home_page.dart';
import 'package:app_eyewear/view/layout.dart';
import 'package:app_eyewear/view/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static String tag = '/splash-page';

  @override
  Widget build(BuildContext context) {
    // Recupera a instancia do controller
    var userController = Provider.of<UserController>(context);
    userController.checkIsLoggedIn().then((UserAuthStatus status) async {
      // Mata toda sas rotas anteorios

       await Future.delayed(Duration(milliseconds: 2000), () {
        // ignore: use_build_context_synchronously
        Navigator.of(context).popUntil((route) => route.isFirst);

        if (status == UserAuthStatus.loggedIn) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).popAndPushNamed(HomePage.tag);
        } else {
          // ignore: use_build_context_synchronously
          Navigator.of(context).popAndPushNamed(LoginPage.tag);
        }
      });
    });

    return Scaffold(
      backgroundColor: Layout.secondary(),
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
          Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
