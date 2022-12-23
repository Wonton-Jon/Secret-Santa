import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthApi {
  static final _googleSignIn =
      GoogleSignIn(scopes: ['https://mail.google.com/']);

  static Future<GoogleSignInAccount?> signIn() async {
    if (await _googleSignIn.isSignedIn() && _googleSignIn.currentUser != null) {
      print('is signed in');
      return _googleSignIn.currentUser;
    } else {
      print('is not signed in');
      return await _googleSignIn.signIn();
    } //end if
  }
}
