import 'package:flutter/material.dart';
import 'package:inventory_flutter/Components/BottomSheet.dart';

class CategoryPill extends StatelessWidget {
  const CategoryPill(
      {Key key,
      @required this.label,
      @required this.rafeeHas,
      @required this.uthsobHas,
      @required this.bottomSheet,
      this.ontap})
      : super(key: key);

  final String label;

  final int rafeeHas;
  final int uthsobHas;
  final String bottomSheet;
  final Function ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ontap(label, rafeeHas, uthsobHas);
      },
      child: Padding(
        padding: const EdgeInsets.all(40.0).copyWith(bottom: 100, right: 0),
        child: GestureDetector(
          onDoubleTap: () {
            if (bottomSheet == 'main') {
              showBottomSheetMain(context, label, rafeeHas, uthsobHas);
            }
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
      ),
    );
  }
}
