import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:rycky_and_morty_app/components/loader_component.dart';
import 'package:rycky_and_morty_app/helpers/api_helper.dart';
import 'package:rycky_and_morty_app/models/character.dart';
import 'package:rycky_and_morty_app/models/response.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({ Key? key }) : super(key: key);

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  bool _showLoader = false;

  List<Character> _characters = [];
  String _description = '';
  @override
  void initState() {
    super.initState();
    _getCharacters();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _showLoader ? LoaderComponent(text: 'Por favor espere...') : _getContent(),
      ),
    );
  }

  Widget _getContent() {
    return _getListView();
  }
  
  Widget _getListView() {
    return RefreshIndicator(
      onRefresh: _getCharacters,
      child: ListView(
        children: _characters.map((e) {
          return Card(
            child: InkWell(
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e.name, 
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Future<Null> _getCharacters() async {
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

    Response response = await ApiHelper.getCharacters();

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
      _characters = response.result;
    });
  }
}