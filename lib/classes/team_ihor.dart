import 'package:kingzcourt/classes/player.dart';

List<Object> teamOfTwo = [
  ['OH', 'L'],
  ['OP', 'M', 'S']
];

List<Object> teamOfThree = [
  ['L', 'OH'],
  'S',
  ['OP', 'M']
];

List<Object> teamOfFour = [
  'OH',
  'OP',
  'S',
  ['M', 'L']
];

List<Object> teamOfFive = ['OH', 'OP', 'S', 'M', 'L'];​
List<Object> teamOfSix = ['OH', 'OH', 'OP', 'S', 'M', 'L'];

class Team {
  String _teamName;
  int _teamSize; //2-6 players
  List<Player> _playerList; //list of Players on the Team
  
  List<Object> _positions;

  Team(String myTeamName, int myTeamSize) {
    _teamName = myTeamName;

    updateTeamSize(myTeamSize);

    _playerList = List(); //makes an empty list, leaving it empty for now
  }

  //getters:
  String getTeamName() {
    return _teamName;
  }

  List<Player> getPlayersOnTeam() {
    return _playerList;
  }

  List<Object> getPositions() {
    return _positions;
  }

  int get teamSize => _teamSize;

  void removePosition(String position) {
    if (_teamSize == 5 || _teamSize == 6) {
      _positions.remove(position);
      return;
    } else {
      for (Object o in _positions) {
        if (o.runtimeType != String) {
          if ((o as List<String>).contains(position)) {
            _positions.remove(o);
            return;
          }
        } else if ((o as String) == position) {
          _positions.remove(o);
          return;
        }
      }
    }
  }

  //TODO implement contains positions
  bool isPositionAvailiable(String position) {
    bool isAvailiable = false;
    if (_teamSize == 5 || _teamSize == 6) {
      return _positions.contains(position);
    } else {
      for (Object o in _positions) {
        if (o.runtimeType != String) {
          if ((o as List<String>).contains(position)) {
            isAvailiable = true;
            return isAvailiable;
          }
        } else {
          if ((o as String) == position) {
            isAvailiable = true;
            return isAvailiable;
          }
        }
      }
    }
    return isAvailiable;
  }

  bool isTeamFull() {
    return _positions.isEmpty;
  }

  void updateTeamSize(int newTeamSize) {
    _teamSize = newTeamSize;

    switch (newTeamSize) {
      case 2:
        _positions = teamOfTwo;
        break;
      case 3:
        _positions = teamOfThree;
        break;
      case 4:
        _positions = teamOfFour;
        break;
      case 5:
        _positions = teamOfFive;
        break;
      case 6:
        _positions = teamOfSix;
        break;
      default:
        _positions = teamOfSix;
        break;
    }
  }

  //setters:
  void setTeamName(String newTeamName) {
    _teamName = newTeamName;
  }

  void addPlayer(Object o) {
    Player player = o;
    _playerList.add(player);
  }

  void removePlayer(Object o) {
    Player playerToRemove = o;
    _playerList.remove(playerToRemove);
  }

  //not sure how to return the player list so it can be printed
  /*
  String toString() {
    return "Team name: $getTeamName() " + "Team size: $_playerList.size";
  }*/
}