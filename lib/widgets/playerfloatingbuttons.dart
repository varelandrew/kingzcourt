import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_cropper/image_cropper.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

import 'package:kingzcourt/classes/colors.dart';
import '../classes/player.dart';
import '../pages/playerlibrary.dart';

class PlayerFloatingButtons extends StatefulWidget {
  @override
  _PlayerFloatingButtonsState createState() => _PlayerFloatingButtonsState();
}

class _PlayerFloatingButtonsState extends State<PlayerFloatingButtons> {
  TextEditingController firstName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  ImagePicker picker = new ImagePicker();
  var border = CircleBorder();
  List<String> positions;
  int selectedIndex;
  PickedFile _img_from_gallery;
  String _img64;

  Future _imgFromGallery() async {
    _img_from_gallery = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 700,
        maxWidth: 700);
    if (_img_from_gallery != null) {
      Uint8List bytes = await _img_from_gallery.readAsBytes();
      setState(() {
        _img64 = base64Encode(bytes);
      });
    }
  }

  @override
  void initState() {
    selectedIndex = 0;
    positions = ['OH', 'M', 'OP', 'S', 'L'];
    super.initState();
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = PlayerLibraryPage().of(context);
    return Builder(
      builder: (context) => Visibility(
          visible: !state.deleteModeOn,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setState) => new AlertDialog(
                            title: Text("Add Player"),
                            content: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                      width: 100,
                                      height: 100,
                                      child: GestureDetector(
                                          onTap: () => _imgFromGallery(),
                                          child: _img64 == null
                                              ? FittedBox(
                                                  fit: BoxFit.fill,
                                                  child: Icon(Icons.add_a_photo,
                                                      color: AppColors
                                                          .primaryAccentDark))
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: Image.memory(
                                                    base64Decode(_img64),
                                                  )))),
                                  TextFormField(
                                    controller: firstName,
                                    decoration:
                                        InputDecoration(hintText: 'First Name'),
                                  ),
                                  TextFormField(
                                    controller: lastName,
                                    decoration:
                                        InputDecoration(hintText: 'Last Name'),
                                  ),
                                  Container(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 55,
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 5,
                                        crossAxisCount: 5,
                                      ),
                                      // shrinkWrap: true,
                                      itemCount: positions.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return FlatButton(
                                            splashColor: AppColors.primaryColor,
                                            shape: CircleBorder(),
                                            color: index == selectedIndex
                                                ? AppColors.primaryColor
                                                : Colors.white,
                                            onPressed: () => {
                                                  setState(() {
                                                    selectedIndex = index;
                                                  })
                                                },
                                            child: Text(positions[index],
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                    color: index ==
                                                            selectedIndex
                                                        ? Colors.white
                                                        : AppColors
                                                            .primaryDarkColor)));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              new FlatButton(
                                color: AppColors.primaryDarkColor,
                                textColor: Colors.white,
                                child: Text('CANCEL'),
                                onPressed: () {
                                  setState(() {
                                    firstName.clear();
                                    lastName.clear();
                                    selectedIndex = -1;
                                    _img64 = null;
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                              new FlatButton(
                                  color: AppColors.primaryColor,
                                  textColor: Colors.white,
                                  child: new Text('ADD'),
                                  onPressed: () {
                                    state.addPlayer(Player(
                                        firstName.text,
                                        lastName.text,
                                        positions[selectedIndex],
                                        0,
                                        _img64));
                                    firstName.clear();
                                    lastName.clear();
                                    selectedIndex = -1;
                                    _img64 = null;
                                    Navigator.of(context).pop();
                                  })
                            ]),
                      );
                    },
                  );
                  /*state.addPlayer(
                      Player(firstName.text, "Wallen", "OH", 0, "path/path"));*/
                  // updatePlayerData(
                  //     library[9], Player("Hector", "Herrada", "OH", 0, "path/path"));
                  // removePlayerByID(library[1]);
                },
                child: Icon(Icons.add),
                backgroundColor: AppColors.primaryDarkColor,
              ),
              Container(
                width: 0,
                height: 10,
              ),
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  state.setState(() {
                    state.deleteModeOn = true;
                    Scaffold.of(context).showBottomSheet(state.deleteSnackBar);
                  });
                },
                child: Icon(Icons.delete_forever_sharp),
                backgroundColor: AppColors.primaryDarkColor,
              ),
            ],
          )),
    );
  }
}
