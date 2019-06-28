import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  static Future<FirebaseUser> get getCurrentUser  {
    return FirebaseAuth.instance.currentUser();
  }

  UserRepository({ FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn })
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );
    final FirebaseUser user = await _firebaseAuth.signInWithCredential(credential);
    
    print('signed in using Google : ${user.email}');

    return user;
  }

  Future<FirebaseUser> signInWithEmailAndPassword(String email, String password) async {
    final FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    print('signed in using Email : ${user.email}');

    return user;
  }

  Future<FirebaseUser> signUpWithEmailAndPassword({String email, String password}) async {
    final FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return user;
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUserEmail() async {
    String email = (await _firebaseAuth.currentUser()).email;
    return email;
  }

  Future<String> getUsername() async {
    String name = (await _firebaseAuth.currentUser()).displayName;
    return name;
  }

}
