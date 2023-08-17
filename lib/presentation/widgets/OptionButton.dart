import 'package:flutter/material.dart';
    
class OptionButton extends StatelessWidget {

  final String text;
  final IconData icon;
  final double width;
  final VoidCallback onpressed;

  const OptionButton(
      {Key? key, required this.text, required this.icon, required this.width, required this.onpressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.grey),
            splashFactory: NoSplash.splashFactory,
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
          )),
          onPressed: onpressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: Colors.blue,
              ),
              const Padding(padding: EdgeInsets.only(right: 5)),
              Text(
                text,
                style: const TextStyle(color: Colors.white,
                  fontFamily: "Poppins",
                ),
              )
            ],
          )),
    );
  }
}