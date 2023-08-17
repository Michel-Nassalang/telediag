class AppUser {
  final String uid;

AppUser({required this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String surname;
  final String titre;
  final String role;
  final String specialite;
  final String email;
  final String telephone;
  final String etablissement;
  final String side;
  final String profil;

  UserData(this.uid, this.name, this.surname, this.titre, this.role, this.specialite, this.email, this.telephone, this.etablissement, this.side , this.profil);
}