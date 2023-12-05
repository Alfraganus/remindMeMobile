import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:remindme/bloc/EventFormCubit.dart';

class StepTitle extends StatelessWidget {
  const StepTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Note();
  }
}

class Note extends StatefulWidget {
  const Note({Key? key}) : super(key: key);

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
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
                    topRight:
                        Radius.circular(15.0), // Adjust the radius as needed
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    // isScrollControlled: true,
                    builder: (BuildContext context) {
                      return YourBottomModalContent();
                    },
                  );
                  FocusScope.of(context).requestFocus(FocusNode());
                },
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
                            child:
                                Image.asset("assets/icons/icons8-plus-30.png"),
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
                        child: BlocBuilder<EventFormCubit, EventForm>(
                          builder: (context, state) {
                            return Text(
                              state.title.toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            );
                          },
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

class YourBottomModalContent extends StatefulWidget {
  @override
  _YourBottomModalContentState createState() => _YourBottomModalContentState();
}

class _YourBottomModalContentState extends State<YourBottomModalContent> {
  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  ValueNotifier<String> _taskText = ValueNotifier<String>("");

  @override
  void initState() {
    super.initState();
    // Add a listener to the focus node to detect when the keyboard is closed
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        if(_textEditingController.text.isNotEmpty) {
          BlocProvider.of<EventFormCubit>(context)
              .setTitle(_textEditingController.text);
        }
      }
    });

    _textEditingController.addListener(() {
      _taskText.value = _textEditingController.text;
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    _taskText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                // Ensure the text field keeps focus when tapped
                FocusScope.of(context).requestFocus(_focusNode);
              },
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: TextField(
                  autofocus: true,
                  controller: _textEditingController,
                  focusNode: _focusNode,
                  decoration: InputDecoration.collapsed(
                    hintText: 'eg: Meeting with client',
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            BlocBuilder<EventFormCubit, EventForm>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    // Add any logic here when the user taps a button in the modal
                    print('Task: ${_textEditingController.text}');
                    BlocProvider.of<EventFormCubit>(context)
                        .setTitle(_textEditingController.text);
                    Navigator.pop(context); // Close the modal
                  },
                  child: Text('Save'),
                );
              },
            ),
            SizedBox(height: 16),
            // Display the entered text below the Save button
            ValueListenableBuilder<String>(
              valueListenable: _taskText,
              builder: (context, taskText, _) {
                return Text(
                  taskText,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
