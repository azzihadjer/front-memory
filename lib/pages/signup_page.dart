import 'package:flutter/material.dart';
import 'package:memory_main/controller/user_service.dart';
import 'package:memory_main/pages/login_page.dart';
import 'package:memory_main/pages/radioButton.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 3 / 4;
  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;
  double getBigbigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 10 / 11;

  String selectedJobType = '';
  bool showPassword = false;
  TextEditingController usernameController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController(),
      phoneNumberController = TextEditingController(),
      wilayaController = TextEditingController(),
      type_jobController = TextEditingController(),
      profileImgController = TextEditingController(),
      nameServiceController = TextEditingController();

  String get username => usernameController.text;
  String get phoneNumber => phoneNumberController.text;
  String get email => emailController.text;
  String get password => passwordController.text;
  String get type_job => type_jobController.text;
  String get profileImg => profileImgController.text;
  String get nameService => nameServiceController.text;

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> wilayaList = [
      'Adrar',
      'Chlef',
      'Laghouat',
      'Oum El Bouaghi',
      'Batna',
      'Béjaïa',
      'Biskra',
      'Béchar',
      'Blida',
      'Bouira',
      'Tamanrasset',
      'Tébessa',
      'Tlemcen',
      'Tiaret',
      'Tizi Ouzou',
      'Alger',
      'Djelfa',
      'Jijel',
      'Sétif',
      'Saïda',
      'Skikda',
      'Sidi Bel Abbès',
      'Annaba',
      'Guelma',
      'Constantine',
      'Médéa',
      'Mostaganem',
      'M\'Sila',
      'Mascara',
      'Ouargla',
      'Oran',
      'El Bayadh',
      'Illizi',
      'Bordj Bou Arréridj',
      'Boumerdès',
      'El Tarf',
      'Tindouf',
      'Tissemsilt',
      'El Oued',
      'Khenchela',
      'Souk Ahras',
      'Tipaza',
      'Mila',
      'Aïn Defla',
      'Naâma',
      'Aïn Témouchent',
      'Ghardaïa',
      'Relizane',
    ];
    String? selectedWilaya = wilayaList[0];
    return Scaffold(
      backgroundColor: const Color(0xfff4f1e9),
      body: Stack(
        children: [
          Positioned(
              right: -getBigDiameter(context) / 12,
              top: -getBigDiameter(context) / 15,
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
              )),
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
                        Color(0xff578f53),
                        // Color(0xFFBFFFC7),
                        Color(0xff578f53),
                        // Color(0xFFBFFFC7),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )),
              )),
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
                        Color(0xff578f53),
                        Color(0xFFBFFFC7),
                        // Color(0xffc5a78b),
                        Color(0xFFBFFFC7),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )),
              )),
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
                        "Sign Up",
                        style: TextStyle(
                          fontFamily: 'SF Pro Display ProR',
                          fontSize: 35,
                          color: Color(0xfff4f1e9),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      /*  Text(
                        "Back !",
                        style: TextStyle(
                          fontFamily: 'Pacifico',
                          fontSize: 30,
                          color: Color(0xFFF4EBD2),
                          fontWeight: FontWeight.w800,
                        ),
                      ),*/
                    ],
                  ),
                ),
              )),
          Positioned(
              left: -getSmallDiameter(context) / 2.5,
              bottom: -getSmallDiameter(context) / 2,
              child: Container(
                width: getBigDiameter(context),
                height: getSmallDiameter(context),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFBFFFC7),
                        Color(0xffc5a78b),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 130, 20, 10),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      icon: Icon(
                        Icons.person,
                        color: Color(0xff578f53),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 236, 230, 215),
                        ),
                      ),
                      labelText: "Username",
                      labelStyle: TextStyle(
                        color: Color(0xff578f53),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      icon: Icon(
                        Icons.email,
                        color: Color(0xff578f53),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 236, 230, 215),
                        ),
                      ),
                      labelText: "Email",
                      labelStyle: TextStyle(
                        color: Color(0xff578f53),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      icon: Icon(
                        Icons.phone,
                        color: Color(0xff578f53),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 236, 230, 215),
                        ),
                      ),
                      labelText: " Phone N°",
                      labelStyle: TextStyle(
                        color: Color(0xff578f53),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: selectedWilaya,
                    onChanged: (newValue) {
                      setState(() {
                        selectedWilaya = newValue;
                      });
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      icon: Icon(
                        Icons.home,
                        color: Color(0xff578f53),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 236, 230, 215),
                        ),
                      ),
                      labelText: "Wilaya",
                      labelStyle: TextStyle(
                        color: Color(0xff578f53),
                      ),
                    ),
                    items: wilayaList.map((wilaya) {
                      return DropdownMenuItem<String>(
                        value: wilaya,
                        child: Text(wilaya),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: !showPassword,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      icon: const Icon(
                        Icons.vpn_key,
                        color: Color(0xff578f53),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 236, 230, 215),
                        ),
                      ),
                      labelText: "Password",
                      labelStyle: const TextStyle(
                        color: Color(0xff578f53),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color(0xff688f4e),
                        ),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      ),
                    ),
                    // keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                    child: LoginRadioButton(
                        onJobTypeSelected: updateSelectedJobType)),
                Visibility(
                  visible: selectedJobType == 'craftsman',
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: nameServiceController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 236, 230, 215),
                          ),
                        ),
                        labelText: "Name service",
                        labelStyle: TextStyle(
                          color: Color(0xFF7DBD72),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFBFFFC7),
                        Color(0xff578f53),
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
                        final String type_job = selectedJobType;
                        String? wilaya = selectedWilaya;
                        Authentification.register(
                            username,
                            email,
                            password,
                            phoneNumber,
                            wilaya!,
                            profileImg,
                            type_job,
                            nameService);
                      },
                      borderRadius: BorderRadius.circular(20),
                      splashColor: const Color(0xFF7DBD72),
                      child: const Center(
                        child: Text(
                          'CREATE AN ACCOUNT',
                          style: TextStyle(
                            color: Color(0xfff4f1e9),
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
                      "ALREADY HAVE AN ACCOUNT?",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ));
                      },
                      child: const Text(
                        "SIGN IN",
                        style: TextStyle(
                          fontSize: 12,
                          // Color(0xff2b463c),
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

  void updateSelectedJobType(String jobType) {
    setState(() {
      selectedJobType = jobType;
    });
  }
}
