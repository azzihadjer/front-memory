import 'package:flutter/material.dart';
import 'package:memory_main/controller/admin_service.dart';
import 'package:memory_main/controller/user_service.dart';
import 'package:memory_main/pages/signup_page.dart';
import 'package:memory_main/ColorUsed.dart';
import 'package:memory_main/visitor/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ColorUsed color = ColorUsed();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Authentification auth = Authentification();
  Admin admin = Admin();
  bool showPassword = false;
  String get email => emailController.text;
  String get password => passwordController.text;

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 3 / 4;
  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f1e9),
      body: Stack(
        children: [
          Positioned(
            right: -getSmallDiameter(context) / 3,
            top: -getSmallDiameter(context) / 3,
            child: Container(
              width: getBigDiameter(context),
              height: getSmallDiameter(context),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xffc5a78b),
                    Color(0xFFBFFFC7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            left: -getBigDiameter(context) / 4,
            top: -getBigDiameter(context) / 4,
            child: Container(
              width: getBigDiameter(context),
              height: getBigDiameter(context),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xff578f53),
                    Color(0xFFBFFFC7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 45.0,
                    ),
                    Text(
                      "Login",
                      style: TextStyle(
                        fontFamily: 'SF Pro Display ProR',
                        fontSize: 35,
                        color: Color(0xff578f53),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 250, 20, 10),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    color: ColorUsed.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: Color(0xff578f53),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorUsed.fieldColor),
                      ),
                      labelText: "Email",
                      labelStyle: TextStyle(
                        color: Color(0xff578f53),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    color: ColorUsed.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    obscureText: !showPassword,
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.vpn_key,
                        color: Color(0xff688f4e),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 236, 230, 215),
                        ),
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(
                        color: Color(0xff688f4e),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color(0xff688f4e),
                        ),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 20, 10),
                    child: const Text(
                      "Forget Password ?",
                      style: TextStyle(
                        color: Color(0xFF637454),
                        fontSize: 12,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff578f53),
                        Color(0xFFBFFFC7),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        if (email == "admin@gmail.com" &&
                            password == "password") {
                          admin.loginAdmin(email, password);
                        } else {
                          auth.login(email, password);
                        }
                      },
                      borderRadius: BorderRadius.circular(20),
                      splashColor: const Color(0xFF7DBD72),
                      child: const Center(
                        child: Text(
                          'SIGN IN',
                          style: TextStyle(
                            color: ColorUsed.backColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "DON'T HAVE AN ACCOUNT?",
                      style: TextStyle(
                        fontSize: 11,
                        color: ColorUsed.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "SIGN UP",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 241, 187, 26),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "IF YOU ARE VISITOR?",
                      style: TextStyle(
                        fontSize: 11,
                        color: ColorUsed.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      child: const Text(
                        "CLICK HERE ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 241, 187, 26),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
