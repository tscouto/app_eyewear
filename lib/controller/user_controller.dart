import 'package:firebase_auth/firebase_auth.dart';

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

  Future<String?> entrarPorEmailSenha({String? email, String? senha}) async {
    // Validação básica de parâmetros
    if (email == null || senha == null) {
      return 'Email e senha são obrigatórios';
    }

    try {
      var auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );
      await setUser(auth.user);

      return null; // sucesso
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return 'Email inválido';
        case 'user-disabled':
          return 'Usuário desabilitado';
        case 'user-not-found':
          return 'Usuário não encontrado';
        case 'wrong-password':
          return 'Senha incorreta';
        default:
          return 'Erro de autenticação, tente novamente';
      }
    } catch (e) {
      return 'Erro desconhecido, tente novamente!';
    }
  }

  Future<String?> criarContaPorEmailSenha(
    String nome,
    String email,
    String senha,
  ) async {
    try {
      UserCredential cred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: senha);

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

  Future<String?> recuperarSenhaPorEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return null; 
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return 'Email inválido';
      }
      return 'Erro ao tentar recuperar senha';
    } catch (e) {
      return 'Erro desconhecido, tente novamente';
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
