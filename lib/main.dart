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
        '/': (context) => MainPage(),
        '/login': (context) => LoginPage(),
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
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
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
                    Icon(
                      Icons.notifications_active,
                      // color: Colors.white,
                    ),
                    Icon(
                      Icons.search,
                      //color: Colors.white,
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
                  child: ListView(
                    padding:
                        EdgeInsets.symmetric(vertical: 10).copyWith(right: 40),
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      CategoryPill(
                        label: 'Key Ring',
                        rafeeHas: 10,
                        uthsobHas: 20,
                        bottomSheet: 'main',
                      ),
                      CategoryPill(
                        label: 'Music Box',
                        rafeeHas: 15,
                        uthsobHas: 20,
                        bottomSheet: 'main',
                      ),
                      CategoryPill(
                        label: 'Wallet',
                        rafeeHas: 13,
                        uthsobHas: 0,
                        bottomSheet: 'main',
                      ),
                    ],
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
