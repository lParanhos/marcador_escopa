import 'package:flutter/material.dart';
import 'package:marcador_escopa/models/Player.dart';

class Ranking extends StatelessWidget {
  final List<PlayerToScorePoints> players;

  Ranking({Key key, this.players}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: DataTable(
        columnSpacing: 30.0,
        columns: [
          DataColumn(label: Text("Nome")),
          DataColumn(label: Text("Escopas")),
          DataColumn(label: Text("70")),
          DataColumn(label: Text("Total")),
        ],
        rows: List.generate(
            players.length,
            (index) => DataRow(cells: [
                  DataCell(Text(players[index].name)),
                  DataCell(Text(players[index].escopas.toString())),
                  DataCell(Text(players[index].seventy.toString())),
                  DataCell(Text(players[index].total.toString())),
                ])),
      ),
    );
  }
}
