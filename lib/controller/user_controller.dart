import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum UserAuthStatus { waiting, loggedIn, loggedOut }

class UserController {
  User? user;
  UserAuthStatus status = UserAuthStatus.waiting;

  Future<UserAuthStatus> checkIsLoggedIn() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    await setUser(firebaseUser);
    return status;
  }

  Future setUser(User? firebaseUser) async {
    user = firebaseUser;
      status = UserAuthStatus.loggedOut;
    if (user != null) {
     
      status = UserAuthStatus.loggedIn;
    }
    
  }

  Future<String?> criarContaPorEmailSenha(
    String nome,
    String email,
    String senha,
  ) async {

    try {
      UserCredential cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: senha);

      await cred.user!.updateDisplayName(nome);
      await cred.user!.sendEmailVerification();

      await setUser(cred.user);
      //user = cred.user!;
      return null; 
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return 'Email inválido';
        case 'email-already-in-use':
          return 'Este email já está em uso';
        case 'weak-password':
          return 'A senha deve ter no mínimo 6 caracteres';
        default:
          return 'Erro desconhecido, tente novamente';
      }
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
