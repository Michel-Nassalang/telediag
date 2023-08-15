import 'package:Telediag/services/authentification.dart';
import 'package:Telediag/services/loading.dart';
import 'package:animate_do/animate_do.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  final emailControl = TextEditingController();
  final passwordControl = TextEditingController();
  final nameControl = TextEditingController();
  final pseudoControl = TextEditingController();
  final ageControl = TextEditingController();
  String role = "";
  final specialiteControl = TextEditingController();
  final departementControl = TextEditingController();
  final AuthentificationService _auth = AuthentificationService();
  bool showSignIn = true;
  bool isConnected = true;
  late AnimationController controlAnimation;
  late Animation<double> animation;

  @override
  void dispose() {
    emailControl.dispose();
    passwordControl.dispose();
    nameControl.dispose();
    pseudoControl.dispose();
    ageControl.dispose();
    controlAnimation.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controlAnimation = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween(begin: 0.0, end: 0.9).animate(controlAnimation)
      ..addListener(() {
        setState(() {});
      });
    controlAnimation.forward();
  }

  void initView() {
    setState(() {
      _formKey.currentState!.reset();
      error = '';
      emailControl.text = '';
      passwordControl.text = '';
      nameControl.text = '';
      pseudoControl.text = '';
      ageControl.text = '';
      showSignIn = !showSignIn;
    });
  }

  void login() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      if (_formKey.currentState!.validate()) {
        setState(() {
          loading = true;
        });
        var email = emailControl.value.text;
        var password = passwordControl.value.text;
        var name = nameControl.value.text;
        var pseudo = pseudoControl.value.text;
        var age = ageControl.value.text;
        var specialite = specialiteControl.value.text;
        var departement = departementControl.value.text;

        dynamic result = showSignIn
            ? await _auth.signInWithEmailAndPassword(email, password)
            : await _auth.registerWithEmailAndPassword(name, pseudo, age, role,
                specialite, departement, email, password);
        if (result == null) {
          setState(() {
            loading = false;
            error = 'Veuillez vérifier votre adresse mail ou mot de passe.';
          });
          AwesomeSnackbarContent(
            title: "Erreur",
            message: error,
            contentType: ContentType.failure,
          );
        }
      }
    } else {
      setState(() {
        loading = false;
        isConnected = false;
        error = 'Veuillez vérifier votre état de connection.';
      });
      AwesomeSnackbarContent(
        title: "Erreur",
        message: error,
        contentType: ContentType.warning,
      );
    }
  }

  bool eyepass = true;

  InputDecoration fieldecor(String label) {
    return InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
            fontFamily: "Caveat",
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.red, width: 2.0)),
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.red, width: 2.5)),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.lightBlue, width: 2.5)),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.blue, width: 2)),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        fillColor: Colors.grey);
  }

  final Duration duration = const Duration(milliseconds: 800);

  void turneyes() {
    setState(() {
      eyepass = !eyepass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            body: Stack(
            children: [
              Image.asset(
                'assets/images/fond.png',
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              FadeInUp(
                duration: duration,
                delay: const Duration(milliseconds: 800),
                child: SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(0.0, -0.9), end: Offset.zero)
                      .animate(controlAnimation),
                  child: Form(
                    key: _formKey,
                    child: Container(
                      color: Colors.grey.withOpacity(0.6),
                      child: ListView(
                        children: [
                          showSignIn
                              ? const Padding(padding: EdgeInsets.only(top: 50))
                              : const Padding(
                                  padding: EdgeInsets.only(top: 20)),
                          Center(
                              child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(179, 67, 73, 77),
                                border: Border.all(
                                    color: Colors.lightBlue, width: 4),
                                borderRadius: BorderRadius.circular(50)),
                            child: Image.asset('assets/images/logosf.png',
                                width: 65, height: 65),
                          )),
                          const Padding(padding: EdgeInsets.only(top: 5)),
                          Center(
                            child: showSignIn
                                ? const SizedBox()
                                : FadeInUpBig(
                                    duration: duration,
                                    delay: const Duration(milliseconds: 1000),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: TextFormField(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        controller: nameControl,
                                        autofocus: false,
                                        obscureText: false,
                                        maxLines: 1,
                                        validator: (value) => value!.isEmpty
                                            ? 'Donner votre nom'
                                            : null,
                                        decoration: fieldecor("Nom"),
                                      ),
                                    ),
                                  ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 40)),
                          Center(
                            child: showSignIn
                                ? const SizedBox()
                                : FadeInUpBig(
                                    duration: duration,
                                    delay: const Duration(milliseconds: 1100),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: TextFormField(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        controller: pseudoControl,
                                        autofocus: false,
                                        obscureText: false,
                                        maxLines: 1,
                                        validator: (value) => value!.isEmpty
                                            ? 'Donner votre pseudo'
                                            : null,
                                        decoration: fieldecor("Pseudo"),
                                      ),
                                    ),
                                  ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 40)),
                          Center(
                            child: showSignIn
                                ? const SizedBox()
                                : FadeInUpBig(
                                    duration: duration,
                                    delay: const Duration(milliseconds: 1100),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: DropdownButtonFormField(
                                        style:
                                            const TextStyle(color: Colors.grey),
                                        items: ["Aide-soignant", "Expert"]
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            role = value!;
                                          });
                                        },
                                        decoration: fieldecor("Rôle"),
                                      ),
                                    ),
                                  ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 40)),
                          Center(
                            child: showSignIn
                                ? const SizedBox()
                                : FadeInUpBig(
                                    duration: duration,
                                    delay: const Duration(milliseconds: 1200),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: TextFormField(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        controller: specialiteControl,
                                        autofocus: false,
                                        obscureText: false,
                                        maxLines: 1,
                                        validator: (value) => value!.isEmpty
                                            ? 'Donner votre spécialité'
                                            : null,
                                        decoration: fieldecor("Spécialité"),
                                      ),
                                    ),
                                  ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 40)),
                          Center(
                            child: showSignIn
                                ? const SizedBox()
                                : FadeInUpBig(
                                    duration: duration,
                                    delay: const Duration(milliseconds: 1300),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: TextFormField(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        controller: departementControl,
                                        autofocus: false,
                                        obscureText: false,
                                        maxLines: 1,
                                        validator: (value) => value!.isEmpty
                                            ? 'Donner votre departement'
                                            : null,
                                        decoration: fieldecor("Departement"),
                                      ),
                                    ),
                                  ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 40)),
                          Center(
                            child: showSignIn
                                ? const SizedBox()
                                : FadeInUpBig(
                                    duration: duration,
                                    delay: const Duration(milliseconds: 1400),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: TextFormField(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        keyboardType: const TextInputType
                                            .numberWithOptions(),
                                        controller: ageControl,
                                        autofocus: false,
                                        obscureText: false,
                                        maxLines: 1,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Veuillez donner votre age';
                                          } else if (int.parse(value) < 18) {
                                            return 'Vous n\'avez pas l\'age moyenne pour vous inscrire';
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: fieldecor("Age"),
                                      ),
                                    ),
                                  ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 40)),
                          Center(
                            child: FadeInUpBig(
                              duration: duration,
                              delay: const Duration(milliseconds: 1500),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  controller: emailControl,
                                  autofocus: false,
                                  obscureText: false,
                                  maxLines: 1,
                                  validator: (value) => value!.isEmpty
                                      ? 'Donner votre email'
                                      : null,
                                  decoration: fieldecor("Email"),
                                ),
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 40)),
                          Center(
                            child: FadeInUpBig(
                              duration: duration,
                              delay: const Duration(milliseconds: 1600),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    TextFormField(
                                      style:
                                          const TextStyle(color: Colors.white),
                                      controller: passwordControl,
                                      obscureText: eyepass,
                                      maxLines: 1,
                                      autofocus: false,
                                      validator: (value) => value!.length < 6
                                          ? "Donner un mot de passe d'au moins 6 caractères"
                                          : null,
                                      decoration: fieldecor("Password"),
                                    ),
                                    Positioned(
                                        right: 10,
                                        child: Center(
                                          child: IconButton(
                                            icon: Icon((eyepass == false)
                                                ? Icons.remove_red_eye
                                                : Icons
                                                    .remove_red_eye_outlined),
                                            onPressed: turneyes,
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 40)),
                          Center(
                            child: SizedBox(
                              child: ElevatedButton(
                                clipBehavior: Clip.hardEdge,
                                onPressed: login,
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
                                child: showSignIn
                                    ? const Text('Se connecter',
                                        style: TextStyle(
                                            fontFamily: "Caveat",
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 20))
                                    : const Text('Créer un compte',
                                        style: TextStyle(
                                            fontFamily: "Caveat",
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 20)),
                              ),
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              child: ElevatedButton(
                                  autofocus: true,
                                  onPressed: initView,
                                  style: ButtonStyle(
                                      elevation:
                                          MaterialStateProperty.resolveWith(
                                              (states) => 8),
                                      backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) => Colors.grey),
                                      overlayColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) => Colors.blueGrey)),
                                  child: showSignIn
                                      ? const Text('Créer un compte',
                                          style: TextStyle(
                                              fontFamily: "Caveat",
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 20))
                                      : const Text('Se connecter',
                                          style: TextStyle(fontFamily: "Caveat", fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20))),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 40)),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ));
  }
}
