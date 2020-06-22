import 'package:flutter/material.dart';
import 'package:marcador_escopa/models/Player.dart';

class WinnersRank extends StatelessWidget {
  final List<PlayerToScorePoints> players;
  WinnersRank({@required this.players});

  @override
  Widget build(BuildContext context) {
    int length = players.length > 3 ? 3 : players.length;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(length, (index) {
        int rank = index + 1;
        String player = players[index].name;
        return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.green),
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.only(top: 20, bottom: 20, left: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 25,
                  child: Text(
                    "$rankº",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(width: 16.0),
                Container(
                  width: 80,
                  child: Text("$player",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                )
              ],
            ));
      }),
    );
  }
}
