import 'package:flutter/material.dart';
import 'package:marcador_escopa/models/player.dart';
import 'package:marcador_escopa/utils/colors.dart';

enum ActionType { decrement, increment }
enum TopicType { moreCards, moreGolds, scoredSeventy, escopas, goldPoints }

class AddPoints extends StatefulWidget {
  List<PlayerToScorePoints> players = [];
  AddPoints({this.players});

  @override
  _AddPointsState createState() => _AddPointsState();
}

class _AddPointsState extends State<AddPoints> {
  List<PlayerToScorePoints> scorePoints = [];

  String whoHasMoreCards = "";
  String whoHasMoreGoldCards = "";
  String whoHasSeventy = "";

  List<Step> steps = [];
  int count = 0;

  @override
  void initState() {
    super.initState();
    scorePoints.removeRange(0, scorePoints.length);
    setState(() {
      for (int i = 0; i < widget.players.length; i++) {
        PlayerToScorePoints p = new PlayerToScorePoints(widget.players[i].name);
        scorePoints.add(p);
      }
    });
  }

  void handleUpdateEscopa(ActionType type, String name) {
    int index = scorePoints.indexWhere((element) => element.name == name);
    setState(() {
      if (type == ActionType.increment)
        scorePoints[index].escopas++;
      else if (type == ActionType.decrement && scorePoints[index].escopas > 0)
        scorePoints[index].escopas--;
    });
  }

  void handleUpdatePoints(ActionType type, String name) {
    int index = scorePoints.indexWhere((element) => element.name == name);
    setState(() {
      if (type == ActionType.increment)
        scorePoints[index].goldCards++;
      else if (type == ActionType.decrement && scorePoints[index].escopas > 0)
        scorePoints[index].goldCards--;
    });
  }

  void sumPointsAndSendToScore() {
    List<PlayerToScorePoints> score = [];

    for (int i = 0; i < scorePoints.length; i++) {
      PlayerToScorePoints player =
          widget.players.firstWhere((p) => p.name == scorePoints[i].name);
      if (scorePoints[i].name == whoHasMoreCards) {
        player.moreCards++;
      }
      if (scorePoints[i].name == whoHasMoreGoldCards) {
        player.moreGolds++;
      }
      if (scorePoints[i].name == whoHasSeventy) {
        player.seventy++;
      }

      player.escopas += scorePoints[i].escopas;
      player.goldCards += scorePoints[i].goldCards;

      player.total = player.moreCards +
          player.moreGolds +
          player.seventy +
          player.escopas +
          player.goldCards;
      score.add(player);
    }

    Navigator.pop(context, score);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          title: Text("Vamos adicionar os pontos !"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              scoreSection(1, "Quantas escopas ?", handleUpdateEscopa,
                  TopicType.escopas),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Divider(
                  color: Colors.grey[350],
                ),
              ),
              selectionSection(2, "Quem tem mais cartas ?", widget.players,
                  TopicType.moreCards, whoHasMoreCards),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Divider(
                  color: Colors.grey[350],
                ),
              ),
              selectionSection(3, "Quem tem mais ouros ?", scorePoints,
                  TopicType.moreGolds, whoHasMoreGoldCards),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Divider(
                  color: Colors.grey[350],
                ),
              ),
              selectionSection(4, "Quem fez 70 ?", widget.players,
                  TopicType.scoredSeventy, whoHasSeventy),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Divider(
                  color: Colors.grey[350],
                ),
              ),
              scoreSection(5, "Quantos pontos foram feitos ?",
                  handleUpdatePoints, TopicType.goldPoints),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OutlineButton(
                      borderSide: BorderSide(color: Colors.orange),
                      textColor: Colors.orange,
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      onPressed: () => Navigator.pop(context, widget.players),
                      child: Text("Cancelar"),
                    ),
                    RaisedButton(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: secondary)),
                      color: secondary,
                      onPressed: () => sumPointsAndSendToScore(),
                      child: Text(
                        "Salvar pontos",
                        style: TextStyle(color: white),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  static Widget counter(
      PlayerToScorePoints player, Function handleChange, TopicType type) {
    int points =
        type == TopicType.goldPoints ? player.goldCards : player.escopas;
    return Center(
        child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          width: 150.0,
          padding: EdgeInsets.only(left: 20.0),
          child: Text(player.name),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => handleChange(ActionType.decrement, player.name),
            ),
            Text(points.toString()),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => handleChange(ActionType.increment, player.name),
            ),
          ],
        ),
      ],
    ));
  }

  Widget topic(int number, String title) {
    return Container(
        constraints: BoxConstraints(maxWidth: 280.0, minWidth: 245.0),
        padding: EdgeInsets.only(left: 20.0, right: 0, top: 20.0, bottom: 20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 25.0,
              height: 25.0,
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 20.0),
              decoration: new BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Text(
                "$number",
                style: TextStyle(
                    color: white, fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
            ),
            Text(title)
          ],
        ));
  }

  Widget selectionSection(int number, String title,
      List<PlayerToScorePoints> names, TopicType type, String currentValue) {
    return Row(
      children: <Widget>[
        topic(number, title),
        Container(
          constraints: BoxConstraints(maxWidth: 110.0),
          child: DropdownButton(
            iconSize: 12.0,
            isExpanded: true,
            hint: Text("Escolha.."),
            value: currentValue.isEmpty ? null : currentValue,
            onChanged: (String newValue) {
              // print(newValue);
              setState(() {
                switch (type) {
                  case TopicType.moreCards:
                    whoHasMoreCards = newValue;
                    break;
                  case TopicType.moreGolds:
                    whoHasMoreGoldCards = newValue;
                    break;
                  case TopicType.scoredSeventy:
                    whoHasSeventy = newValue;
                    break;
                  default:
                }
              });
            },
            items: <String>[...names.map<String>((player) => player.name)]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem(
                child: Text(
                  value,
                  //overflow: TextOverflow.ellipsis,
                ),
                value: value,
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  Widget scoreSection(
      int number, String title, Function update, TopicType type) {
    return Container(
      child: Container(
          alignment: Alignment.center,
          child: Wrap(
            children: <Widget>[
              topic(number, title),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(scorePoints.length,
                    (index) => counter(scorePoints[index], update, type)),
              ),
            ],
          )),
    );
  }
}
