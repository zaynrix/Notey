import 'package:flutter/material.dart';
import 'package:notey/features/Home/homeScreen.dart';
import 'package:notey/features/Settings/settingProvider.dart';
import 'package:notey/interceptors/di.dart';
import 'package:notey/models/taskModel.dart';
import 'package:notey/resources/color_manager.dart';
import 'package:notey/shared/widgets/CustomAppBar.dart';
import 'package:notey/shared/widgets/CustomCTAButton.dart';
import 'package:provider/provider.dart';

class TypographyScreen extends StatelessWidget {
  TypographyScreen({Key? key}) : super(key: key);

  // double _value = 5;

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: CustomAppBar(
          title: 'Typography',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                noteCard(
                  stop: true,
                  element: Data.obj(),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Colors",
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Fonts -  size : ${10* sl<SettingProvider>().textSize}",
                      style: Theme.of(context).textTheme.headline2,
                    ),

                  ],
                ),
                Text(
                  "Fonts -  size",
                  style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 50),
                ),

                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  decoration: new BoxDecoration(
                      color: ColorManager.black,
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(5.0)),
                      boxShadow: [
                        new BoxShadow(
                            color: Colors.black38,
                            offset: new Offset(0.0, 2.0),
                            blurRadius: 10)
                      ]),
                  child: new Slider(

                    value: value.textSize,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white,

                    onChanged: (double s) => value.changeSize(s),
                    divisions: 10,
                    min: 1.0,
                    max: 5.0,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomeCTAButton(
                  title: "Save",
                  trigger: false,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
