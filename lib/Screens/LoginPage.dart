import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_flutter/Components/BackGroundGradient.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;
  String errorMessage = '';

  void setErrorMessage(String errorMsg) {
    setState(() {
      errorMessage = errorMsg;
    });
  }

  void _login() async {
    try {
      final user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (user != null) {
        Navigator.pushNamed(context, '/main');
      }
    } catch (error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          setErrorMessage("Your email address appears to be malformed.");
          break;
        case "ERROR_WRONG_PASSWORD":
          setErrorMessage("Your password is wrong.");
          break;
        case "ERROR_USER_NOT_FOUND":
          setErrorMessage("User with this email doesn't exist.");
          break;
        case "ERROR_USER_DISABLED":
          setErrorMessage("User with this email has been disabled.");
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          setErrorMessage("Too many requests. Try again later.");
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          setErrorMessage("Signing in with Email and Password is not enabled.");
          break;
        default:
          setErrorMessage("An undefined Error happened.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: BackgroundGradient),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 45),
              child: Text(
                'Login',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Text(
                'Welcome Back',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 19,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        //padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(227, 95, 27, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                            color: Colors.white),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10).copyWith(left: 25),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey[200]),
                                ),
                              ),
                              child: TextField(
                                onChanged: (value) {
                                  email = value;
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter Email Address',
                                  hintStyle: TextStyle(color: Colors.grey[500]),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10).copyWith(left: 25),
                              decoration: BoxDecoration(),
                              child: TextField(
                                onChanged: (value) {
                                  password = value;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: 'Enter Password',
                                    hintStyle:
                                        TextStyle(color: Colors.grey[500]),
                                    border: InputBorder.none),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20).copyWith(top: 30),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          _login();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * .35,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.orange[900],
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Center(
                          child: Text('$errorMessage'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
