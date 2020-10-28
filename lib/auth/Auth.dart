import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class SignInSignUpResult {
  final User user;
  final String message;

  SignInSignUpResult({this.user, this.message});
}

class Auth {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<SignInSignUpResult> signUp(
      {String email, String password}) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return SignInSignUpResult(user: result.user);
    } catch (e) {
      return SignInSignUpResult(
        message: e.toString(),
      );
    }
  }

  static Future<SignInSignUpResult> signIn(
      {String email, String password}) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return SignInSignUpResult(user: result.user);
    } catch (e) {
      return SignInSignUpResult(
        message: e.toString(),
      );
    }
  }

  Future<User> getCurrentUser() async {
    User user = auth.currentUser;
    return user;
  }

  static Future<void> signOut() async {
    return auth.signOut();
  }

  Future<void> sendEmailVerification() async {
    User user = auth.currentUser;
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    User user = auth.currentUser;
    return user.emailVerified;
  }
}
