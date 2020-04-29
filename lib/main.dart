import 'package:flutter/material.dart';
import 'package:inventory_flutter/Components/BackGroundGradient.dart';
import 'Screens/LoginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inventory Management',
      home: MainPage(),
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
                      ),
                      CategoryPill(
                        label: 'Music Box',
                        rafeeHas: 15,
                        uthsobHas: 20,
                      ),
                      CategoryPill(
                        label: 'Wallet',
                        rafeeHas: 13,
                        uthsobHas: 0,
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
            )
          ],
        ),
      ),
    );
  }
}

class CategoryPill extends StatelessWidget {
  const CategoryPill(
      {Key key,
      @required this.label,
      @required this.rafeeHas,
      @required this.uthsobHas})
      : super(key: key);

  final String label;

  final int rafeeHas;
  final int uthsobHas;

  Widget buildBottomSheet(BuildContext context) {
    return Container(
        //color: Colors.orange[400],
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$label',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Rafee: $rafeeHas pc',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Uthsob: $uthsobHas pc',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0).copyWith(bottom: 140, right: 0),
      child: GestureDetector(
        onDoubleTap: () {
          showModalBottomSheet(
            backgroundColor: Colors.orange[300],
            context: context,
            builder: buildBottomSheet,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 5), color: Colors.orange, blurRadius: 5)
              ]),
          width: 200,
          child: Center(
              child: Text(
            '$label',
            style: TextStyle(
              fontSize: 25,
              color: Colors.black87,
            ),
          )),
        ),
      ),
    );
  }
}
