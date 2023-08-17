import 'package:Telediag/data/models/User.dart';
import 'package:Telediag/data/repositories/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthentificationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AppUser _userFromFirebase(User? user){
    if (user != null) {
      return AppUser(uid: user.uid);
    }else{
      return null!;
    }
  }

  Stream<AppUser> get user{
    return _auth.authStateChanges().map(_userFromFirebase);
  }
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      return null;
    }
  }
  
  Future registerWithEmailAndPassword(String name, String surname, String titre, String role, String specialite, String email,
      String tel, String etablissement, String side, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      await DatabaseService(user!.uid).saveUser(name, surname, titre, role, specialite, email, tel, etablissement, side, 'profil.png');
      return _userFromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future sOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
