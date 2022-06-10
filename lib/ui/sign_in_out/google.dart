import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  // Once signed in, return the UserCredential
  final user =  await FirebaseAuth.instance.signInWithCredential(credential);
  return user;
}

signOut() async {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final GoogleSignIn googleUser = await GoogleSignIn(scopes: <String>["email"]);

  await _firebaseAuth.signOut();
  googleUser.signOut();

}

