import 'package:Telediag/data/models/User.dart';
import 'package:Telediag/presentation/screens/WelcomeScreen.dart';
import 'package:Telediag/services/authentification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      value: AuthentificationService().user,
      initialData: null,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Telediag',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const WelcomeScreen()),
    );
  }
}
