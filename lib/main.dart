import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_flutter/Components/BackGroundGradient.dart';
import 'package:inventory_flutter/Screens/InventoryPage.dart';
import 'Components/CategoryPill.dart';
import 'Screens/LoginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inventory Management',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/main': (context) => MainPage(),
        '/inventory': (context) => InventoryPage()
      },
      theme: ThemeData(
        primaryColor: Color(0xFFFF9800),
        primaryColorDark: Color(0xFFF57C00),
        accentColor: Color(0xFF7C4DFF),
        iconTheme: IconThemeData(color: Color(0xFF212121), size: 30),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  FirebaseUser loggedInUser;
  String loggedInUserText;

  void getCurrentUser() async {
    try {
      final user = await FirebaseAuth.instance.currentUser();

      if (user != null) {
        loggedInUser = user;

        setState(() {
          if (loggedInUser.email == 'r.nahid111@gmail.com') {
            loggedInUserText = 'Rafee';
          } else {
            loggedInUserText = 'Uthsob';
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();

    Navigator.popUntil(
      context,
      ModalRoute.withName('/'),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: BackgroundGradient),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        _logout();
                      },
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.person),
                        Text(
                          '$loggedInUserText',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Center(
                child: Container(
                  width: double.infinity,
                  //height: MediaQuery.of(context).size.height * .50,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.orange[300],
                          blurRadius: 5,
                          offset: Offset(0, 2))
                    ],
                    color: Colors.white30,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                    ),
                  ),
                  child: StreamBuilder<QuerySnapshot>(
                    stream:
                        Firestore.instance.collection('Categories').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        var messageList = snapshot.data.documents;

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: messageList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CategoryPill(
                              label: messageList[index]['label'],
                              rafeeHas: messageList[index]['rafeeHas'],
                              uthsobHas: messageList[index]['uthsobHas'],
                              bottomSheet: 'main',
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/inventory');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 25),
                        child: Text(
                          'Inventory',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
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
