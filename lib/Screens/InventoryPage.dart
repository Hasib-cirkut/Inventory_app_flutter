import 'package:flutter/material.dart';
import 'package:inventory_flutter/Components/BackgroundGradient.dart';
import 'package:inventory_flutter/Components/CategoryPill.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InventoryPage extends StatefulWidget {
  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final _auth = FirebaseAuth.instance;
  final _fireStore = Firestore.instance;
  FirebaseUser loggedInUser;

  int amount = 0;

  List<String> selectedText = ['ADD option selected', 'SELL option selected'];
  int selectedTextIndex = 0;

  String selectedCategory = '';
  String transactionUser = '';
  bool showNegativeQuantityError = false;

  int rafeeHas;
  int uthobHas;

  bool addSelected = true;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();

      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void handlePillButton(String type) {
    int tempAmount = amount;

    if (type == '-5') {
      tempAmount -= 5;
    } else if (type == '-1') {
      tempAmount -= 1;
    } else if (type == '+1') {
      tempAmount += 1;
    } else if (type == '+5') {
      tempAmount += 5;
    }

    if (tempAmount < 0) {
      return;
    } else {
      setState(() {
        amount = tempAmount;
      });
    }
  }

  void transact(BuildContext context) async {
    try {
      if (!addSelected) {
        amount = amount * -1;
      }

      if (loggedInUser.email == 'r.nahid111@gmail.com') {
        int temp = rafeeHas + amount;

        if (temp < 0) {
          setState(() {
            showNegativeQuantityError = true;
            amount = 0;
            return;
          });
        } else {
          _fireStore
              .collection('Categories')
              .document(selectedCategory)
              .updateData({'rafeeHas': (rafeeHas + amount)});
          showNegativeQuantityError = false;
        }
      } else {
        int temp = uthobHas + amount;

        if (temp < 0) {
          setState(() {
            showNegativeQuantityError = true;
            amount = 0;
            return;
          });
        } else {
          _fireStore
              .collection('Categories')
              .document(selectedCategory)
              .updateData({'uthsobHas': uthobHas + amount});
          showNegativeQuantityError = false;
        }
      }

      if (!showNegativeQuantityError) {
        Navigator.pop(context);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void setSelectedCategory(String selectedCat, int rH, int uH) {
    setState(() {
      if (selectedCat == 'Coin Purse') {
        selectedCategory = 'coin_purse';
      } else if (selectedCat == 'Music Box') {
        selectedCategory = 'music_box';
      } else if (selectedCat == 'Key Ring') {
        selectedCategory = 'key_ring';
      } else if (selectedCat == 'Stickers') {
        selectedCategory = 'sticker';
      } else if (selectedCat == 'Wallet') {
        selectedCategory = 'wallet';
      }

      rafeeHas = rH;
      uthobHas = uH;
    });
  }

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
              child: Container(),
            ),
            Expanded(
              flex: 4,
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
                              bottomSheet: 'inventory',
                              ontap: setSelectedCategory,
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
              child: Center(
                child: Text(
                  "$selectedCategory selected",
                  style: TextStyle(fontSize: 27, color: Colors.black87),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTextIndex = 0;
                                addSelected = true;
                              });
                            },
                            child: AddSellButton(
                              label: 'ADD',
                              icon: Icons.add,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTextIndex = 1;
                                addSelected = false;
                              });
                            },
                            child: AddSellButton(
                              label: 'SELL',
                              icon: Icons.close,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Text(
                        selectedText[selectedTextIndex],
                        style: TextStyle(
                            color: selectedTextIndex == 0
                                ? Colors.green[800]
                                : Colors.red[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              handlePillButton('-5');
                            },
                            child: PillButton(
                              label: '-5',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              handlePillButton('-1');
                            },
                            child: PillButton(
                              label: '-1',
                            ),
                          ),
                          Text(
                            '$amount',
                            style: TextStyle(fontSize: 25),
                          ),
                          GestureDetector(
                            onTap: () {
                              handlePillButton('+1');
                            },
                            child: PillButton(
                              label: '+1',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              handlePillButton('+5');
                            },
                            child: PillButton(
                              label: '+5',
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      transact(context);
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
                          'Transact',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: showNegativeQuantityError
                  ? Center(
                      child: Text(
                      'Can\'t add negative amount of Items',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ))
                  : Text(''),
            )
          ],
        ),
      ),
    );
  }
}

class PillButton extends StatelessWidget {
  const PillButton({@required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '$label',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(10),
    );
  }
}

class AddSellButton extends StatelessWidget {
  AddSellButton({@required this.label, @required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: label == 'ADD' ? Colors.green : Colors.red,
      ),
      child: Text(
        label,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
