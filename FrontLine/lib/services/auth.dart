import 'package:firebase_auth/firebase_auth.dart';
import 'package:web_app/services/database.dart';
import 'package:web_app/services/datetime.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Date _date = Date();

  //sign in anonympusly
  Future signinanon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User userdetails = result.user;
      return userdetails;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in email and password
  Future signInEmailPwd(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User userdetails = result.user;
      return userdetails;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register email and password
  Future regEmailPwd(String email, String password, String username) async {
    try {
      String date = await _date.getTodayDate();
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      await _auth.currentUser.updateProfile(displayName: username);
      User userdetails = result.user;
      await DatabaseService(uid: userdetails.uid)
          .updateAttendanceCollectionData(username, date, false);
      await DatabaseService(uid: username).updateUserProfileCollectionData(
          username, 'Full Name', 'Dr- Cardiologist', '2 Years');
      print('printing..');
      print('${_auth.currentUser}');
      return userdetails;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future logOut() async {
    try {
      return _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
