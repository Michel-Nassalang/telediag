import 'package:Telediag/data/models/User.dart';
import 'package:Telediag/presentation/screens/ExpertHome.dart';
import 'package:Telediag/presentation/screens/SoignantHome.dart';
import 'package:Telediag/services/init.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebase = FirebaseAuth.instance;
    final user = firebase.currentUser;
    final actu = Provider.of<UserData?>(context);
    if (user != null || actu != null) {
      return actu!.role == "Expert" ? const ExpertHome() : const SoignantHome();
    }else {
      return const Initial();
    }
  }
}
