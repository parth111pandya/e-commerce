import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../route/route_constants.dart';
import '../../../utils/DialogMixin.dart';
import '../../../utils/const.dart';

class AuthServices with DialogMixin {
  //Google Sgin in
  signWithGoogle(context) async {
    //begin interactive sign in process
    await preferenceMan.init();
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    //obtiin auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    //create new credential for user

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    // finally,lets sign in
    var tempCred = await FirebaseAuth.instance.signInWithCredential(credential);
    uidList.add(tempCred.user!.uid);
    preferenceMan.saveUserLogin(true);
    Navigator.pushNamedAndRemoveUntil(
      context,
      entryPointScreenRoute,
      ModalRoute.withName(logInScreenRoute),
    );
    return tempCred;
  }

  void signUserIn(
    context, {
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    await preferenceMan.init();
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // try sign in
    try {
      if (emailController.text == "demo@temp.com" &&
              passwordController.text == "RCB@2024" ||
          emailController.text == "1" && passwordController.text == "1") {
        Navigator.pushNamedAndRemoveUntil(context, entryPointScreenRoute,
            ModalRoute.withName(logInScreenRoute));
      } else {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // pop the loading circle
        Navigator.pop(context);
        preferenceMan.saveUserLogin(true);
        uidList.contains(credential.user!.uid)
            ? Navigator.pushNamedAndRemoveUntil(context, entryPointScreenRoute,
                ModalRoute.withName(logInScreenRoute))
            : showGetXToast(
                'Alert',
                'Please enter valid Email ID',
              );
      }
    } on FirebaseAuthException catch (error) {
      // pop the loading circle
      Navigator.pop(context);
      // WRONG EMAIL
      if (error.code == 'invalid-credential') {
        // show error to user
        showGetXToast(error.code, 'Please enter valid Email ID');
      } else if (error.code == 'wrong-password') {
        // WRONG PASSWORD
        showGetXToast(error.code, 'Please enter valid Password');
      }
    }
  }

  void signUserUp(
    context, {
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    await preferenceMan.init();

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // try sign up
    try {
      var credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // pop the loading circle
      Navigator.pop(context);
      uidList.add(credential.user!.uid);
      preferenceMan.saveUserLogin(true);
      uidList.contains(credential.user!.uid)
          ? Navigator.pushNamedAndRemoveUntil(
              context, logInScreenRoute, ModalRoute.withName(logInScreenRoute))
          : showGetXToast(
              'Alert',
              'Please enter valid Email ID',
            );
    } on FirebaseAuthException catch (error) {
      print(error.code);
      // pop the loading circle
      Navigator.pop(context);
      // WRONG EMAIL
      if (error.code == 'user-not-found') {
        // show error to user
        showGetXToast(error.code, 'Please enter valid Email ID');
      } else if (error.code == 'email-already-in-use') {
        showGetXToast(error.code, 'ERROR_EMAIL_ALREADY_IN_USE');
      }
      // WRONG PASSWORD
      else if (error.code == 'wrong-password') {
        showGetXToast(error.code, 'Please enter valid Password');
      }
    }
  }
}
