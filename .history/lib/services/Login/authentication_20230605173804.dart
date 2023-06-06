import 'package:valuid/services/database/database.dart';
import 'package:valuid/shared/printFunctions/custom_Print_Functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:valuid/models/user/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:valuid/shared/sample/sampleData.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  UserObject? _userFromFirebaseUser(User? user) {
    try {
      if (user != null) {
        return UserObject(uid: user.uid, email: user.email == null ? 'n/a' : user.email, name: '');
      } else {
        return null;
      }
    } catch (e) {
      PrintFunctions().printError(e);

      return null;
    }
  }

  //! auth chnage user stream
  Stream<UserObject> get user {
    // ignore: deprecated_member_use
    try {
      return _auth.userChanges().map(_userFromFirebaseUser);
    } catch (e) {
      print('error in database');
      return null;
    }
  }

  //! Sing in with Email & Password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);

      User user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      PrintFunctions().printError(e);

      return null;
    }
  }

  //! register with email &Password
  Future registerWithEmailAndPassword({String email, String password}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      User user = result.user;

      await DatabaseService(uid: user.uid).updateUserData(data: {
        'portfolios': SampleData().getSamplePortfolio(),
        'account': {
          'accountType': 'free',
          'email': email,
          'currency': 'USD',
          'isVertified': user.emailVerified
        }
      });

      return _userFromFirebaseUser(user);
    } catch (e) {
      PrintFunctions().printError(e);

      return null;
    }
  }

  //! Sign out BNHBV B76YTGFVC
  Future signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      PrintFunctions().printError(e);

      return null;
    }
  }

  //! Reset Password
  Future passwordReset({String? email}) async {
    await _auth.sendPasswordResetEmail(email: email.toString());
  }

  //! Delete User
  Future deleteUser(String email, String password) async {
    try {
      User? user = _auth.currentUser;

      AuthCredential credentials = EmailAuthProvider.credential(email: email, password: password);
      UserCredential result = await user!.reauthenticateWithCredential(credentials);

      await DatabaseService(uid: result.user!.uid).deleteuser();
      await result.user!.delete();

      return true;
    } catch (e) {
      PrintFunctions().printError(e);

      return null;
    }
  }

  //!Google SignIn
  Future googleSinIn() async {
    try {
      final user = await _googleSignIn.signIn();

      if (user == null) {
        return null;
      } else {
        final googleAuth = await user.authentication;
        final credential =
            GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        var result = await FirebaseAuth.instance.signInWithCredential(credential);

        if (result.additionalUserInfo!.isNewUser) {
          await result.user!.delete();
          _googleSignIn.disconnect();

          return null;
        } else {
          return _userFromFirebaseUser(result.user);
        }
      }
    } catch (e) {
      PrintFunctions().printError(e);

      return null;
    }
  }

  //!Google SignUp
  Future googleSignUp() async {
    try {
      final user = await _googleSignIn.signIn();

      if (user == null) {
        print('error');

        return null;
      } else {
        final googleAuth = await user.authentication;
        final credential =
            GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        var result = await FirebaseAuth.instance.signInWithCredential(credential);

        print(result.user.uid);

        User curretUser = result.user;

        await DatabaseService(uid: curretUser.uid).updateUserData(data: {
          'portfolios': SampleData().getSamplePortfolio(),
          'account': {
            'accountType': 'free',
            'email': user.email,
            'currency': 'USD',
            'isVertified': true,
          }
        });

        return _userFromFirebaseUser(curretUser);
      }
    } catch (e) {
      PrintFunctions().printError(e);

      return null;
    }
  }

  //! Google Sign Out
  Future googleLogout() async {
    try {
      await _googleSignIn.disconnect();
      FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (e) {
      PrintFunctions().printError(e);

      return null;
    }
  }

  Future deleteGoogleAccount() async {
    try {
      final user = await _googleSignIn.signIn();
      final googleAuth = await user.authentication;
      final credential =
          GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      var result = await FirebaseAuth.instance.signInWithCredential(credential);

      User u = FirebaseAuth.instance.currentUser;
      await DatabaseService(uid: u.uid).deleteuser();
      await result.user.delete();
      await _googleSignIn.disconnect();

      return true;
    } catch (e) {
      PrintFunctions().printError(e.toString());

      return null;
    }
  }
}
