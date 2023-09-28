import 'package:flutter/material.dart';

class LoginRadioButton extends StatefulWidget {
final Function(String) onJobTypeSelected;

const LoginRadioButton({Key? key, required this.onJobTypeSelected})
      : super(key: key);

  @override
  _LoginRadioButtonState createState() => _LoginRadioButtonState();
}

class _LoginRadioButtonState extends State<LoginRadioButton> {
  String loginType = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Job Type: ",
            style: TextStyle(
              fontFamily: 'SF Pro Display ProR',
              fontSize: 19,
              color: Color(0xFF7DBD72),
              fontWeight: FontWeight.bold,
            ),
          ),
          Radio(
            value: 'craftsman',
            groupValue: loginType,
             onChanged: (value) {
              setState(() {
                loginType = value!;
                widget.onJobTypeSelected(loginType);
              });
            },
            activeColor: const Color.fromARGB(255, 244, 186, 12),
          ),
          const Text(
            'Craftsman',
            style: TextStyle(color: Color(0xFF7DBD72), fontSize: 15),
          ),
          const SizedBox(width: 2.0),
          Radio(
            value: 'patron',
            groupValue: loginType,
            onChanged: (value) {
              setState(() {
                loginType = value!;
                widget.onJobTypeSelected(loginType);
              });
            },
            activeColor: const Color.fromARGB(255, 244, 186, 12),
          ),
          const Text(
            'Patron',
            style: TextStyle(color: Color(0xFF7DBD72), fontSize: 15),
          ),
        ],
      ),
    );
  }
}
