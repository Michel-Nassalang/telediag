import 'package:Telediag/data/models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService(this.uid);

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("Users");

  final DateTime now = DateTime.now();

  Future<void> saveUser(
      String name,
      String surname,
      String titre,
      String role,
      String specialite,
      String email,
      String telephone,
      String etablissement,
      String side,
      String profil) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'surname': surname,
      'titre': titre,
      'date': now,
      'role': role,
      'specialite': specialite,
      'email': email,
      'telephone': telephone,
      'etablissement': etablissement,
      'side': side,
      'profil': profil
    });
  }

  Future<void> profilUser(String content) async {
    return await userCollection.doc(uid).update({'profil': content});
  }

  Future<void> saveToken(String? token) async {
    return await userCollection.doc(uid).update({'token': token});
  }

  UserData _userFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        snapshot.id,
        snapshot.get('name'),
        snapshot.get('surname'),
        snapshot.get('titre'),
        snapshot.get('role'),
        snapshot.get('specialite'),
        snapshot.get('email'),
        snapshot.get('telephone'),
        snapshot.get('etablissement'),
        snapshot.get('side'),
        snapshot.get('profil'));
  }

  Stream<UserData> getUser(String uidKey) {
    return userCollection.doc(uidKey).snapshots().map(_userFromSnapshot);
  }

  Stream<UserData> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }

  Iterable<UserData> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => _userFromSnapshot(doc));
  }

  Stream<Iterable<UserData>> get userList {
    return userCollection
        .orderBy('name')
        .snapshots()
        .map(_userListFromSnapshot);
  }
}
