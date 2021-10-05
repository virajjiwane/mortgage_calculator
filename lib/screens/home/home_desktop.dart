import 'package:flutter/material.dart';

class HomeDesktop extends StatelessWidget {
  HomeDesktop({
    Key? key,
    required this.input,
    required this.result,
    required this.constraints,
  }) : super(key: key);

 final Widget input;
 final Widget result;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: constraints.maxHeight*0.01),
          child: Text(
            "Mortgage Calculator",
            style: TextStyle(
              fontSize: 50,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(constraints.maxHeight*0.008),
          child: Text("Just enter your amount, tenure and interest to calculate your monthly installments"),
        ),
        Padding(
          padding: EdgeInsets.all(constraints.maxWidth*0.01),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                input,
                Flexible(
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth*0.01),
                    child: VerticalDivider(
                      color: Colors.white70,
                    ),
                  ),
                ),
                result,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
