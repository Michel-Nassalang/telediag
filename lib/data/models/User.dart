class AppUser {
  final String uid;

AppUser({required this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String pseudo;
  final String age;
  final String role;
  final String specialite;
  final String departement;
  final String profil;

  UserData(this.uid, this.name, this.pseudo, this.age, this.role, this.specialite, this.departement, this.profil);
  
}