import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:rycky_and_morty_app/components/loader_component.dart';
import 'package:rycky_and_morty_app/helpers/api_helper.dart';
import 'package:rycky_and_morty_app/models/character.dart';
import 'package:rycky_and_morty_app/models/response.dart';

class CharacterScreen extends StatefulWidget {
  final Character character;

  CharacterScreen({required this.character});
  @override
  _CharacterScreenState createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  bool _showLoader = false;
  late Character _character;

  @override
  void initState() {
    super.initState();
    _character = widget.character;
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_character.name),
      ),
      body: Center(
        child: _showLoader 
        ? LoaderComponent(text: 'Por favor espere...') 
        : _getContent(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _goAdd(),
      ),
    );
  }

  Widget _showUserInfo() {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          Expanded(                      
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Foto: ', 
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              FadeInImage(
                                placeholder: AssetImage('assets/not_found.png'), 
                                image: NetworkImage(_character.image),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover
                              ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: <Widget>[
                            Text(
                              'Id: ', 
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            Text(
                              _character.id.toString(), 
                              style: TextStyle(
                              fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: <Widget>[
                            Text(
                              'Name: ', 
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            Text(
                              _character.name, 
                              style: TextStyle(
                              fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: <Widget>[
                            Text(
                              'Status: ', 
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            Text(
                              _character.status, 
                              style: TextStyle(
                              fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: <Widget>[
                            Text(
                              'Species: ', 
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            Text(
                              _character.species, 
                              style: TextStyle(
                              fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: <Widget>[
                            Text(
                              'Type: ', 
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            Text(
                              _character.type, 
                              style: TextStyle(
                              fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: <Widget>[
                            Text(
                              'Gender: ', 
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            Text(
                              _character.gender, 
                              style: TextStyle(
                              fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: <Widget>[
                            Text(
                              'Origin/Name: ', 
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                           for ( var i in _character.origin ) Text(i.name)
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: <Widget>[
                            Text(
                              'Origin/Url: ', 
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                           for ( var i in _character.origin ) Text(i.url)
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: <Widget>[
                            Text(
                              'Location/Name: ', 
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                           for ( var i in _character.location ) Text(i.name)
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: <Widget>[
                            Text(
                              'Location/Url: ', 
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                           for ( var i in _character.location ) Text(i.url)
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: <Widget>[
                            Text(
                              'Episodes: ', 
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                           for ( var i in _character.episode ) Text(i)
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: <Widget>[
                            Text(
                              'Url: ', 
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            Text(
                              _character.url, 
                              style: TextStyle(
                              fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: <Widget>[
                            Text(
                              'Created: ', 
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            Text(
                              _character.created, 
                              style: TextStyle(
                              fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> _getUser() async {
    setState(() {
      _showLoader = true;
    });

    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _showLoader = false;
      });

      await showAlertDialog(
        context: context,
        title: 'Error',
        message: 'Verifica que estes conectado a internet',
        actions: <AlertDialogAction>[
          AlertDialogAction(key: null, label: 'Aceptar'),
        ]
      );
      return;
    }

    Response response = await ApiHelper.getCharacter(_character.id);

    setState(() {
      _showLoader = false;
    });

    if (!response.isSuccess) {
      await showAlertDialog(
        context: context,
        title: 'Error',
        message: response.message,
        actions: <AlertDialogAction>[
          AlertDialogAction(key: null, label: 'Aceptar'),
        ]
      );
      return;
    }

    setState(() {
      _character = response.result;
    });
  }

  _goAdd() {

  }

  Widget _getContent() {
    return Column(
      children: <Widget>[
        _showUserInfo(),
      ],
    );
  }

  Widget _noContent() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Text(
          'El usuario no tiene vehiculos registrados.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold, 
          ),
        ),
      ),
    );
  }
}