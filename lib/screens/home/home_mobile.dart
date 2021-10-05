import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:mortgage_calculator/utils/pallet/pallet.dart';

class HomeMobile extends StatefulWidget {
  HomeMobile({
    Key? key,
    required this.input,
    required this.result,
    required this.constraints,
  }) : super(key: key);

  final Widget input;
  final Widget result;
  final BoxConstraints constraints;

  @override
  _HomeMobileState createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  bool isResultShown = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: widget.constraints.maxHeight*0.01),
          child: Text(
            "Mortgage Calculator",
            style: TextStyle(
              fontSize: 50,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(widget.constraints.maxHeight*0.008),
          child: Text(
            "Just enter your amount, tenure and interest to calculate your monthly installments",
            textAlign: TextAlign.center,
          ),
        ),
        Divider(
          color: Colors.white70,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: widget.constraints.maxHeight*0.01),
          child: IntrinsicHeight(
            child: Column(
              children: [
                isResultShown ? widget.result : widget.input,
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(widget.constraints.maxHeight*0.008),
          child: GestureDetector(
            onTap: () {
              isResultShown = !isResultShown;
              setState(() {});
            },
            child: GlassmorphicContainer(
              height: widget.constraints.maxHeight * 0.05,
              width: widget.constraints.maxWidth * 0.6,
              borderRadius: widget.constraints.maxHeight * 0.01,
              blur: 10,
              alignment: Alignment.center,
              border: 1,
              linearGradient: LinearGradient(
                colors: [bgColor.withOpacity(0.2), bgColor.withOpacity(0.3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderGradient: LinearGradient(
                colors: [
                  Colors.white70.withOpacity(0.2),
                  Colors.white24.withOpacity(0.2),
                ],
              ),
              child: Center(
                child: Text(
                  isResultShown ? "Show Input" : "Show Result",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
