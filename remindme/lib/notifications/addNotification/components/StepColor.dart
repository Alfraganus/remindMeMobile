import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:remindme/bloc/ColorChooserCubit.dart';
import 'package:remindme/services/saveSchedularStepper.dart';

class StepColor extends StatelessWidget {
  const StepColor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColorOption(Color: "#24A19C"),
        SizedBox(height: 40),
        ColorOption(Color: "#1B1C1F"),
        SizedBox(height: 40),
        ColorOption(Color: "#EA4335"),
        SizedBox(height: 40),
        ColorOption(Color: "#1877F2"),
        SizedBox(height: 40),
      ],
    );
  }
}

class ColorOption extends StatelessWidget {
  final String Color;

  const ColorOption({
    super.key,
    required this.Color,
  });

  @override
  Widget build(BuildContext context) {
    final bottomNavBarCubit = BlocProvider.of<ColorChooserCubit>(context);
    double screenHeight = MediaQuery.of(context).size.width;
    double topPosition = screenHeight * 0.03;
    return BlocBuilder<ColorChooserCubit, ColorChooserState>(
      builder: (context, state) {
        bool isActive = state.selectedColor == Color;
        return InkWell(
          onTap: () {
            // print(Color);
            bottomNavBarCubit.changeSelectedColor(Color);
            SaveSchedular.saveSchedular('color', Color);
          },
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 60,
                    decoration: new BoxDecoration(
                      color: HexColor(Color),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(
                            15.0), // Adjust the radius as needed
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 45,
                    child: Image.asset(
                      'assets/images/Frame 11.png',
                      fit: BoxFit.cover, // Adjust the BoxFit property as needed
                    ),
                  ),

                ],
              ),
              if (isActive)
                Positioned(
                  bottom: 0,
                  left: topPosition,
                  child: Container(
                      height: 50,
                      margin: EdgeInsets.only(top: 0),
                      decoration: BoxDecoration(
                          color: HexColor(state.selectedColor.toString()),
                          border: Border.all(
                            color: HexColor(state.selectedColor.toString()),
                          ),
                          borderRadius:
                          BorderRadius.all(Radius.circular(50))),
                      child: Image.asset(
                        'assets/icons/tick-icon-transparent-free-png.webp',
                        fit: BoxFit
                            .cover, // Adjust the BoxFit property as needed
                      )),
                ),
            ],
          ),
        );
      },
    );
  }
}
