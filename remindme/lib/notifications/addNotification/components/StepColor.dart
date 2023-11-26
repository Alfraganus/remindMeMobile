import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class StepColor extends StatelessWidget {
  const StepColor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
        height: 60,
          decoration:new BoxDecoration(
            color: HexColor("#24A19C"),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),  // Adjust the radius as needed
              topRight: Radius.circular(15.0), // Adjust the radius as needed
            ),
          ),
        )
      ],
    );
  }
}
