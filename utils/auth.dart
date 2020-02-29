import 'dart:async';
import 'package:firebase/firebase.dart';

abstract class BaseAuth {
  Future<String> googleSignIn();

  Future<User> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class FirebaseAuth implements BaseAuth {
  final Auth _firebaseAuth = auth();

  Future<String> googleSignIn() async {
    try {
      var provider = new GoogleAuthProvider().addScope("email");
      var result = await _firebaseAuth.signInWithPopup(provider);
      User user = result.user;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _firebaseAuth.currentUser;
      assert(user.uid == currentUser.uid);
      return user.uid;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    User user = _firebaseAuth.currentUser;
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    User user =  _firebaseAuth.currentUser;
    return user.emailVerified;
  }
}