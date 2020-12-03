import 'package:flutter/material.dart';

import 'package:kingzcourt/utility/theme.dart';
import 'package:kingzcourt/widgets/drawer.dart';
import '../database/databaseHelper.dart';
import '../classes/player.dart';

class PlayerLibraryPage extends StatefulWidget {
  @override
  _PlayerLibraryPageState createState() => _PlayerLibraryPageState();
}

class _PlayerLibraryPageState extends State<PlayerLibraryPage> {
  List<Player> library = [];
  // add player to database
  void addPlayer(Player p) async {
    DatabaseHelper.instance.insertPlayer(p);
    //library = await DatabaseHelper.instance.getPlayerLibrary();
    //print(library);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        textTheme: Theme.of(context).textTheme,
        title: Text("Saved Players"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => addPlayer(Player("Alex", "OH", 0, "path/path"))),
    );
  }
}