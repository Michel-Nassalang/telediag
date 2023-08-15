import 'package:Telediag/presentation/screens/auth.dart';
import 'package:animate_do/animate_do.dart';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Starting extends StatefulWidget {
  const Starting({Key? key}) : super(key: key);

  @override
  _StartingState createState() => _StartingState();
}

class _StartingState extends State<Starting> {
  final Duration duration = const Duration(milliseconds: 800);
  @override
  List<ConcentricModel> concentrics = [
    ConcentricModel(
      urlimage: "assets/images/prise.png",
      text: "Collecte de données par l'aide-soignant",
    ),
    ConcentricModel(
      urlimage: "assets/images/expert.png",
      text: "Recherche d'experts pour le diagnostic",
    ),
    ConcentricModel(
      urlimage: "assets/images/diagnostic.png",
      text: "Réception du diagnostic pour le patient",
    ),
    ConcentricModel(
      urlimage: "assets/images/consultation.png",
      text: "Communication du diagnostic au patient",
      action: "S'authentifier",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ConcentricPageView(
          onChange: (val) {},
          colors: const <Color>[
            Color.fromARGB(255, 66, 165, 245),
            Colors.blueGrey,
            Color.fromARGB(255, 168, 105, 240),
            Colors.white,
          ],
          itemCount: concentrics.length,
          onFinish: () {
            print("Finished");
          },
          itemBuilder: (int index) {
            return Column(
              children: [
                FadeInUp(
                  duration: duration,
                  delay: const Duration(milliseconds: 1000),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, right: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => const Auth(),
                              ));
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                              color: index == 3 ? Colors.black : Colors.white,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Caveat',
                              fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ),
                FadeInUp(
                  duration: duration,
                  delay: const Duration(milliseconds: 800),
                  child: SizedBox(
                    // height: 290,
                    // width: 300,
                    child: Image.asset(
                      concentrics[index].urlimage,
                      width: 500,
                    ),
                  ),
                ),
                FadeInUp(
                  duration: duration,
                  delay: const Duration(milliseconds: 700),
                  child: Text(
                    concentrics[index].text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Caveat',
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                concentrics[index].action != null
                    ? Center(
                        child: FadeInUpBig(
                          duration: duration,
                          delay: const Duration(milliseconds: 600),
                          child: SizedBox(
                            child: ElevatedButton(
                                clipBehavior: Clip.hardEdge,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            const Auth(),
                                      ));
                                },
                                style: ButtonStyle(
                                    elevation:
                                        MaterialStateProperty.resolveWith(
                                            (states) => 8),
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Colors.lightBlue),
                                    overlayColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Colors.blue[200])),
                                child: Text(
                                  concentrics[index].action!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: 'Caveat',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )),
                          ),
                        ),
                      )
                      : const SizedBox(),
                FadeInUp(
                  duration: duration,
                  delay: const Duration(milliseconds: 500),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      "${index + 1} / ${concentrics.length}",
                      style: const TextStyle(
                        fontFamily: 'Borel',
                        fontStyle: FontStyle.italic,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ConcentricModel {
  String urlimage;
  String text;
  String? action;
  //
  ConcentricModel({
    required this.urlimage,
    required this.text,
    this.action,
  });
}
