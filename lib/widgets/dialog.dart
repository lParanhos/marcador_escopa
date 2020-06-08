import 'package:flutter/material.dart';
import 'package:marcador_escopa/utils/colors.dart';

class FunkyOverlay extends StatefulWidget {
  List<String> players = [];
  FunkyOverlay({this.players});

  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            decoration: ShapeDecoration(
                color: white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Quem Fez Escopa ?"),
                    for (var name in widget.players) counter(name)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget counter(String name) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(name),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {},
            ),
            Text(0.toString()),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }
}
