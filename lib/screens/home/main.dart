import 'package:flutter/material.dart';
import 'package:marcador_escopa/screens/match/main.dart';
import 'package:marcador_escopa/utils/colors.dart';
import 'package:marcador_escopa/widgets/field.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _playersIds = [1, 2];
  Map<int, String> _playerNames = {};

  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  void addPlayer() {
    setState(() {
      int newId = _playersIds.reduce((curr, next) => curr > next ? curr : next);
      _playersIds.add(newId);
    });
  }

  void removePlayer(index) {
    setState(() {
      if (_playersIds.length > 2) {
        _playerNames.remove(index);
        _playersIds.remove(index);
      }
    });
  }

  void takePlayer(String name, int index) {
    String text = name.toString();
    setState(() {
      _playerNames[index] = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: primary,
        title: Text("Marcador de Pontos"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 90.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/playing_cards.png",
              width: 300.0,
              height: 300.0,
            ),
            Text("Adicione novos jogadores e comece a anotar!"),
            Form(
                key: _formKey,
                child: Column(
                  children: List.generate(_playersIds.length, (index) {
                    String label = "Jogador " + (index + 1).toString();
                    bool showDeleteButton = _playersIds.length > 2;
                    bool isDeletable = _playersIds.length == index + 1 &&
                        _playersIds.length > 2;
                    if (isDeletable) {
                      return field(label, index, showDeleteButton, takePlayer,
                          () => removePlayer(_playersIds[index]));
                    }
                    return field(label, index, showDeleteButton, takePlayer);
                  }),
                )),
            RaisedButton(
              onPressed: addPlayer,
              color: secondary,
              child: Text(
                "Adicionar jogador",
                style: TextStyle(color: white),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primary,
        onPressed: () => _startMatch(context),
        icon: Icon(Icons.star),
        label: Text("Iniciar Partida"),
      ),
    );
  }

  _startMatch(BuildContext context) {
    if (_playerNames.length != 0 && _formKey.currentState.validate()) {
      List<String> list = [];
      _playerNames.forEach((key, value) => list.add(value));

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Match(
                    players: list,
                  )));
    }
  }
}
