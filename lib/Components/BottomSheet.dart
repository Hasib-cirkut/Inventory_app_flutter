import 'package:flutter/material.dart';

void showBottomSheetMain(
    BuildContext context, String label, int rafeeHas, int uthsobHas) {
  showModalBottomSheet(
      backgroundColor: Colors.orange[300],
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      builder: (BuildContext context) {
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
          ),
        );
      });
}
