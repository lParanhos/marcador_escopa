import 'package:flutter/material.dart';
import 'package:marcador_escopa/models/Player.dart';
import 'package:marcador_escopa/screens/addPoints/main.dart';
import 'package:marcador_escopa/utils/colors.dart';
import 'package:marcador_escopa/widgets/table.dart';

class Match extends StatefulWidget {
  final List<String> players;

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

  Future<bool> _onWillPop() async {
    return (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Ao sair você perderá os dados da partida !"),
              content: Text("Deseja sair da partida ?"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Não"),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: () => Navigator.of(context).pop(true),
                )
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    print(widget.players);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          title: Text("Partida em andamento"),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceAround,
                  spacing: 30.0,
                  children: List.generate(scoreboard.length,
                      (index) => playerPoint(scoreboard[index])),
                ),
                Ranking(
                  players: scoreboard,
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: secondary,
          icon: Icon(Icons.add),
          label: Text("Marcar"),
          onPressed: () => _navigateToScoreTable(),
        ),
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
