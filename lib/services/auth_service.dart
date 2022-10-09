import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //return instance if a firebase
  //or entry point to firebase authentication
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future loginUserwithEmaiandPassword(
      // ignore: non_constant_identifier_names

      String email,
      String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      // ignore: unnecessary_null_comparison
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signout() async {
    firebaseAuth.signOut();
  }

  Future registerWithUserEmailAndPassword(
      // ignore: non_constant_identifier_names
      String fullName,
      String email,
      String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      // ignore: unnecessary_null_comparison
      if (user != null) {
        //storing data to db

        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
