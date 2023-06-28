import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthenticationRepository {
  Future<UserCredential?> registeruser(
      String emailAddress, String password, String username) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'Entered Password is Weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'Email already in use..');
      }
    } catch (e) {
      return null;
    }
  }

  Future<UserCredential?> loginUser(
      String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);

      if (credential.user != null) {
        Fluttertoast.showToast(
            msg:
                'Welcome ${credential.user?.email ?? 'Email is not Valid or verified.'}');
        return credential;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'User is not Registered.');
        return null;
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'User entered wrong password.');
        return null;
      }
    }
  }
}
