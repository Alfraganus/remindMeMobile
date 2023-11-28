import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:remindme/bloc/ColorChooserCubit.dart';

class StepTitle extends StatelessWidget {
  const StepTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Note(),
      ],
    );
  }
}


class Note extends StatefulWidget {
  const Note({Key? key}) : super(key: key);

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  late FocusNode _focusNode;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    // Dispose the FocusNode only if it's not disposed yet
    if (!_focusNode.hasFocus) {
      _focusNode.dispose();
    }
    _textEditingController.dispose();
    super.dispose();
  }

  void handleTap() {
    // Request focus on the hidden TextField
    if (_focusNode != null && !_focusNode.hasFocus) {
      FocusScope.of(context).requestFocus(_focusNode);
    }
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.width;
    return  RawKeyboardListener(
      focusNode: _focusNode,
      onKey: (RawKeyEvent event) {
        if (_focusNode == null || !_focusNode.hasFocus) {
          return;
        }
        if (event.runtimeType == RawKeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.enter) {
        }
      },
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 60,
                decoration: new BoxDecoration(
                  color: HexColor("#24A19C"),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(
                        15.0), // Adjust the radius as needed
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: handleTap,
                child: Row(
                  children: [
                    Container(
                      width: screenHeight * 0.16,
                      // height: 150,
                      // color: Colors.lightBlue,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: HexColor("#24A19C"),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Image.asset(
                                "assets/icons/icons8-plus-30.png"),
                          ),
                          width: 50,
                          height: 50,
                          // color: Colors.white,
                        ),
                      ),
                    ),
                    VerticalDivider(width: 2.0),
                    Expanded(
                      child: Container(
                        width: 100,
                        // color: HexColor('#24A19C'),
                        child: Text(
                          "Tap plus to create a new task",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Divider(color: Colors.black12),
              Align(
                alignment: Alignment.topRight,
                child: Text("Today Mon 20 Jul 2023",
                    style: TextStyle(
                      fontSize: 16,
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
