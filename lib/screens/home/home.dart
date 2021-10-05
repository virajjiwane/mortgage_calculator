import 'dart:math';

import "package:flutter/material.dart";
import 'package:glassmorphism/glassmorphism.dart';
import 'package:mortgage_calculator/responsive.dart';
import 'package:mortgage_calculator/screens/home/home_desktop.dart';
import 'package:mortgage_calculator/screens/home/home_mobile.dart';
import 'package:mortgage_calculator/utils/utils.dart';
import 'package:number_display/number_display.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  final _display = createDisplay(
    length: 20,
    decimal: 2,
  );

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int tenure = 5;
  int principalAmount = 10000;
  double interestRate = 0.2;

  String emiResult = '';

  double totalPayable = 0;

  @override
  Widget build(BuildContext context) {
    double monthlyEmi = getMonthlyInstallment(
      principalAmount: principalAmount,
      interestRate: interestRate,
      months: tenure,
    );
    emiResult = widget._display(
      monthlyEmi,
    );
    totalPayable = monthlyEmi * tenure;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                bgColor,
                inactive,
                active,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Positioned(
                    top: -constraints.maxHeight * 0.05,
                    left: -constraints.maxWidth * 0.1,
                    child: Image.asset(
                      'assets/images/abstract_object_2.png',
                      height: constraints.maxHeight * 0.5,
                      width: constraints.maxWidth * 0.5,
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.61,
                    right: constraints.maxWidth * 0.001,
                    child: Image.asset(
                      'assets/images/abstract_object_1.png',
                      height: constraints.maxHeight * 0.5,
                      width: constraints.maxWidth * 0.5,
                    ),
                  ),
                  Center(
                    child: GlassmorphicContainer(
                      height: constraints.maxHeight * 0.8,//(Responsive.isMobile(context) ? 0.8 : 0.6),
                      width: constraints.maxWidth * 0.8,
                      borderRadius: constraints.maxHeight * 0.01,
                      blur: 15,
                      alignment: Alignment.center,
                      border: 2,
                      linearGradient: LinearGradient(
                          colors: [Colors.white10.withOpacity(0.2), Colors.white.withOpacity(0.3)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderGradient: LinearGradient(colors: [Colors.white70.withOpacity(0.2), Colors.white24.withOpacity(0.2)]),
                      child: Responsive(
                        mobile: HomeMobile(
                          input: buildInput(constraints),
                          result: buildResult(constraints),
                          constraints: constraints,
                        ),
                        desktop: HomeDesktop(
                          input: buildInput(constraints),
                          result: buildResult(constraints),
                          constraints: constraints,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildInput(BoxConstraints constraints) => Flexible(
        fit: FlexFit.tight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Principal Amount"),
                  Text(
                    "₹ ${widget._display(principalAmount)}",
                    style: TextStyle(
                      locale: Locale.fromSubtags(countryCode: "ind"),
                    ),
                  )
                ],
              ),
            ),
            Slider(
                max: 300000,
                min: 100,
                value: principalAmount.roundToDouble(),
                onChanged: (e) {
                  setState(() {
                    principalAmount = e.toInt();
                  });
                }),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tenure"),
                  Text(
                    "$tenure Months",
                  )
                ],
              ),
            ),
            Slider(
                max: 48,
                min: 1,
                value: tenure.roundToDouble(),
                divisions: 48,
                onChanged: (e) {
                  setState(() {
                    tenure = e.toInt();
                  });
                }),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Interest Rate(per month)"),
                  Text("₹ ${widget._display(totalPayable - principalAmount)}"),
                  Text(
                    "${interestRate*100} %",
                    style: TextStyle(
                      locale: Locale.fromSubtags(countryCode: "ind"),
                    ),
                  )
                ],
              ),
            ),
            Slider(
              max: 0.5,
              min: 0.01,
              value: interestRate,
              onChanged: (e) {
                setState(
                  () {
                    interestRate = double.parse(e.toStringAsFixed(2));
                  },
                );
              },
            ),
          ],
        ),
      );

  Widget buildResult(BoxConstraints constraints) => Flexible(
        fit: FlexFit.tight,
        child: CircularPercentIndicator(
          radius: min(constraints.maxHeight, constraints.maxWidth) * 0.4,
          percent: principalAmount / (totalPayable),
          progressColor: Colors.white,
          backgroundColor: secondaryColor,
          lineWidth: max(constraints.maxHeight, constraints.maxWidth) * 0.01,
          center: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "₹ $emiResult",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w200,
                ),
              ),
              Text(
                "/Month",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          footer: Padding(
            padding: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.01),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  color: Colors.white70.withOpacity(0.2),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(constraints.maxHeight * 0.008),
                          child: Container(
                            color: Colors.white,
                            height: constraints.maxHeight * 0.01,
                            width: constraints.maxHeight * 0.01,
                          ),
                        ),
                        Text("Principal Amount"),
                      ],
                    ),
                    Text("₹ ${widget._display(principalAmount)}"),
                  ],
                ),
                Divider(
                  color: Colors.white70.withOpacity(0.2),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(constraints.maxHeight * 0.008),
                          child: Container(
                            color: secondaryColor,
                            height: constraints.maxHeight * 0.01,
                            width: constraints.maxHeight * 0.01,
                          ),
                        ),
                        Text("Interest"),
                      ],
                    ),
                    Text("₹ ${widget._display(totalPayable-principalAmount)}"),
                  ],
                ),
                Divider(
                  color: Colors.white70.withOpacity(0.2),
                ),
              ],
            ),
          ),
        ),
      );
}
