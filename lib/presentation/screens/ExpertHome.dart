import 'package:flutter/material.dart';
    
class ExpertHome extends StatefulWidget {
  const ExpertHome({Key? key}) : super(key: key);

  @override
  _ExpertHomeState createState() => _ExpertHomeState();
}

class _ExpertHomeState extends State<ExpertHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Partie expert'),
      ),
      body: const Center(child: Text("Partie Expert")),
    );
  }
}