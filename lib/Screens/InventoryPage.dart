import 'package:flutter/material.dart';
import 'package:inventory_flutter/Components/BackgroundGradient.dart';
import 'package:inventory_flutter/Components/CategoryPill.dart';

class InventoryPage extends StatefulWidget {
  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  int amount = 0;

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
                  child: ListView(
                    padding:
                        EdgeInsets.symmetric(vertical: 10).copyWith(right: 40),
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      CategoryPill(
                        label: 'Key Ring',
                        rafeeHas: 10,
                        uthsobHas: 20,
                        bottomSheet: 'inventory',
                      ),
                      CategoryPill(
                        label: 'Music Box',
                        rafeeHas: 15,
                        uthsobHas: 20,
                        bottomSheet: 'inventory',
                      ),
                      CategoryPill(
                        label: 'Wallet',
                        rafeeHas: 13,
                        uthsobHas: 0,
                        bottomSheet: 'inventory',
                      ),
                    ],
                  ),
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
                          AddSellButton(
                            label: 'ADD',
                            icon: Icons.add,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          AddSellButton(
                            label: 'SELL',
                            icon: Icons.close,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
                          Text('$amount'),
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
              flex: 1,
              child: Container(
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
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
