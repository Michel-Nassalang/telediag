import 'package:Telediag/data/models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService(this.uid);

  final CollectionReference userCollection = FirebaseFirestore.instance.collection("Users");

  final DateTime now = DateTime.now();

  Future<void> saveUser(String name, String pseudo, String age, String role,  String specialite, String departement, String profil) async {
    return await userCollection.doc(uid).set({
      'name' : name,
      'pseudo' : pseudo,
      'age' : age,
      'date' : now,
      'role' : role,
      'specialite': specialite,
      'departement': departement,
      'profil' : profil
    });
  }

  Future<void> profilUser(String content) async {
    return await userCollection.doc(uid).update({'profil': content});
  }


  Future <void> saveToken(String? token) async{
    return await userCollection.doc(uid).update({'token':token});
  }


  UserData _userFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      snapshot.id,
      snapshot.get('name'),
      snapshot.get('pseudo'),
      snapshot.get('age'),
      snapshot.get('role'),
      snapshot.get('specialite'),
      snapshot.get('departement'),
      snapshot.get('profil')
    );
  }

  Stream<UserData>  getUser(String uidKey) {
    return userCollection.doc(uidKey).snapshots().map(_userFromSnapshot);
  }

  Stream<UserData> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }

  Iterable<UserData> _userListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) => _userFromSnapshot(doc));
  }

  Stream<Iterable<UserData>> get userList {
    return userCollection.orderBy('name').snapshots().map(_userListFromSnapshot);
  }
}
