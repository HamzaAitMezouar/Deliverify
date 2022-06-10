import 'package:deliverify/src/controllers/apis/usersApi.dart';
import 'package:deliverify/src/models/userModel.dart';
import 'package:deliverify/src/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends StatefulWidget {
  String text;
  RegisterPage(this.text);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late bool haveAccount;
  final key = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String email;
  late String name;
  late String password;
  bool obs = true;
  double x = -1;
  double y = -1;
  @override
  void initState() {
    super.initState();

    if (widget.text == 'Login') {
      haveAccount = true;
    } else {
      haveAccount = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {
                    haveAccount = !haveAccount;
                    emailController.clear();
                    passwordController.clear();
                    nameController.clear();
                  });
                },
                child: Text(haveAccount ? 'Register' : 'Login'))
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(haveAccount ? 'Login' : 'Register',
                  style: GoogleFonts.ebGaramond(
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600))),
            ),
            Form(
                key: key,
                child: haveAccount
                    ? Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          emailTextField(size),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          passwordTextField(size),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: appBarTitle,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  fixedSize: Size(
                                      size.width * 0.6, size.height * 0.06)),
                              onPressed: key.currentState != null &&
                                      key.currentState!.validate()
                                  ? () {
                                      setState(() {
                                        x = 1;
                                        y = 1;
                                      });
                                      usersApi().login(email, password);
                                    }
                                  : null,
                              child: const Text('Login'))
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          nameTextField(size),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          emailTextField(size),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          passwordTextField(size),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: appBarTitle,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  fixedSize: Size(
                                      size.width * 0.6, size.height * 0.06)),
                              onPressed: key.currentState != null &&
                                      key.currentState!.validate()
                                  ? () {
                                      userModel user = userModel(
                                          displayName: name,
                                          email: email,
                                          password: password);
                                      setState(() {
                                        x = 1;
                                        y = 1;
                                      });
                                      usersApi().register(user);
                                      user.displayName;
                                    }
                                  : null,
                              child: const Text('Register')),
                        ],
                      )),
            Spacer(),
            AnimatedContainer(
              duration: Duration(seconds: 3),
              alignment: Alignment(y, x),
              height: size.height * 0.2,
              child: Lottie.network(
                  'https://assets4.lottiefiles.com/packages/lf20_e4lzqxv7.json'),
            ),
          ],
        ),
      ),
    );
  }

  Widget emailTextField(Size size) {
    return SizedBox(
      height: size.height * 0.06,
      width: size.width * 0.90,
      child: TextFormField(
        controller: emailController,
        obscureText: false,
        key: const ValueKey('email'),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email),
          label: const Text('E-mail'),
          labelStyle: GoogleFonts.adamina(),
        ),
        validator: (val) {
          String pattern =
              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
              r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
              r"{0,253}[a-zA-Z0-9])?)*$";
          RegExp regex = RegExp(pattern);
          if (val!.isEmpty || !regex.hasMatch(val)) {
            return 'Enter a valid email address';
          } else {
            return null;
          }
        },
        onChanged: (val) => setState(() {
          email = val;
        }),
      ),
    );
  }

  Widget nameTextField(Size size) {
    return SizedBox(
      height: size.height * 0.06,
      width: size.width * 0.90,
      child: TextFormField(
        controller: nameController,
        obscureText: false,
        key: const ValueKey('name'),
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          prefixIcon: const Icon(FontAwesomeIcons.user),
          label: const Text('Name'),
          labelStyle: GoogleFonts.adamina(),
        ),
        validator: (val) => val!.isEmpty ? 'Enter your name' : null,
        onChanged: (val) => setState(() {
          name = val;
        }),
      ),
    );
  }

  Widget passwordTextField(Size size) {
    return SizedBox(
      height: size.height * 0.06,
      width: size.width * 0.90,
      child: TextFormField(
        controller: passwordController,
        obscureText: obs,
        key: const ValueKey('password'),
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          /*  suffix: IconButton(
              onPressed: () {
                setState(() {
                  obs = !obs;
                });
              },
              icon: obs
                  ? const Icon(
                      FontAwesomeIcons.eyeSlash,
                    )
                  : const Icon(FontAwesomeIcons.eye)),*/
          prefixIcon: const Icon(Icons.lock),
          label: const Text('Password'),
          labelStyle: GoogleFonts.adamina(),
        ),
        validator: (val) => val!.isEmpty || val.length < 6
            ? 'Your password is too short'
            : null,
        onChanged: (val) => setState(() {
          password = val;
        }),
      ),
    );
  }
}
