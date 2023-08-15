import 'package:Telediag/data/models/User.dart';
import 'package:Telediag/data/repositories/database.dart';
import 'package:Telediag/presentation/screens/WelcomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:Telediag/presentation/screens/Home.dart';
import 'package:provider/provider.dart';

class Initial extends StatefulWidget {
  const Initial({Key? key}) : super(key: key);

  @override
  _InitialState createState() => _InitialState();
}

class _InitialState extends State<Initial> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebase = FirebaseAuth.instance;
    final user = firebase.currentUser;
    final actu = Provider.of<AppUser?>(context);
    if (user == null || actu == null) {
      return const WelcomeScreen();
    } else {
      return StreamProvider<UserData>.value(initialData: UserData(actu.uid,'','','','','','',''),
      value: DatabaseService(actu.uid).user,
      child:  const Home());
    }
    
  }
}
