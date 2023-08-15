import 'package:Telediag/presentation/screens/Starting.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final Duration duration = const Duration(milliseconds: 800);

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then((value) =>
        Navigator.of(context).pushReplacement(
            CupertinoPageRoute(builder: (context) => const Starting())));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      body: Container(
        margin: const EdgeInsets.all(8),
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ///
            FadeInUp(
              duration: duration,
              delay: const Duration(milliseconds: 2000),
              child: Container(
                margin: const EdgeInsets.only(
                  top: 50,
                  left: 5,
                  right: 5,
                ),
                // width: size.width,
                // height: size.height / 2,
                child: Image.asset(
                  "assets/images/logosf.png",
                  width: 500,
                ),
              ),
            ),

            ///
            const SizedBox(
              height: 15,
            ),

            /// TITLE
            FadeInUp(
              duration: duration,
              delay: const Duration(milliseconds: 1600),
              child: const Text(
                "Telediag",
                style: TextStyle(
                    fontFamily: "Caveat",
                    color: Colors.blue,
                    fontSize: 40,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),

            ///
            const SizedBox(
              height: 10,
            ),

            FadeInUp(
              duration: duration,
              delay: const Duration(milliseconds: 800),
              child: const Text(
                "Avec Télédiag, transformons la santé et le bien-être à portée de main.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Borel",
                    height: 1.2,
                    color: Colors.grey,
                    fontSize: 17,
                    fontWeight: FontWeight.w300),
              ),
            ),
            ///
            const SizedBox(
              height: 20,
            ),

            FadeInUp(
                duration: duration,
                delay: const Duration(milliseconds: 600),
                child: SpinKitFadingCube(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: index.isEven ? Colors.blue : Colors.blue[300],
                      ),
                    );
                  },
                )),

            ///
            const SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
