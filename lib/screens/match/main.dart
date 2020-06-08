import 'package:flutter/material.dart';
import 'package:marcador_escopa/models/player.dart';
import 'package:marcador_escopa/screens/addPoints/main.dart';
import 'package:marcador_escopa/utils/colors.dart';

class Match extends StatefulWidget {
  List<String> players = [];
  Match({Key key, this.players}) : super(key: key);

  @override
  _MatchState createState() => _MatchState();
}

class _MatchState extends State<Match> {
  List<PlayerToScorePoints> scoreboard = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      widget.players
          .forEach((name) => scoreboard.add(new PlayerToScorePoints(name)));
    });
  }

  void _navigateToScoreTable() async {
    final List<PlayerToScorePoints> result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddPoints(
                  players: scoreboard,
                ),
            fullscreenDialog: true));
    bool valid = result != null;

    setState(() {
      if (valid) scoreboard = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.players);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text("Partida em andamento"),
      ),
      body: Container(
          child: SizedBox.expand(
        child: Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.spaceAround,
          children: List.generate(
              scoreboard.length, (index) => playerPoint(scoreboard[index])),
        ),
      )),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: secondary,
        icon: Icon(Icons.add),
        label: Text("Marcar"),
        onPressed: () => _navigateToScoreTable(),
      ),
    );
  }

  Widget playerPoint(PlayerToScorePoints player) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 20.0, top: 20.00),
          child: Text(
            player.name,
            style: TextStyle(fontSize: 20.0, color: Colors.red),
          ),
        ),
        Text(player.total.toString(), style: TextStyle(fontSize: 40.0))
      ],
    );
  }
}
