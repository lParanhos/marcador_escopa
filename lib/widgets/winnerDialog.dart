import 'package:flutter/material.dart';
import 'package:marcador_escopa/models/Player.dart';

class WinnerDialog extends StatelessWidget {
  final String title, buttonText;
  final Image image;
  final Widget players;

  WinnerDialog({
    @required this.title,
    @required this.players,
    @required this.buttonText,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context, title, players, buttonText),
      ),
    );
  }
}

dialogContent(
    BuildContext context, String title, Widget players, String buttonText) {
  return Stack(
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(
          top: 64.00,
          bottom: 16.0,
          left: 16.0,
          right: 16.0,
        ),
        margin: EdgeInsets.only(top: 32.0),
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 16.0),
            players,
            SizedBox(height: 24.0),
            Align(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(); // To close the dialog
                },
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
      Positioned(
        left: 16.0,
        right: 16.0,
        child: CircleAvatar(
          backgroundColor: Colors.orangeAccent,
          radius: 40.0,
          child: CircleAvatar(
            radius: 38,
            backgroundImage: AssetImage('assets/winner.png'),
          ),
        ),
      ),
    ],
  );
}
