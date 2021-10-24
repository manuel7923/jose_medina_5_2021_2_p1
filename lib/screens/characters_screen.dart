import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:rycky_and_morty_app/components/loader_component.dart';
import 'package:rycky_and_morty_app/helpers/api_helper.dart';
import 'package:rycky_and_morty_app/models/character.dart';
import 'package:rycky_and_morty_app/models/response.dart';
import 'package:rycky_and_morty_app/screens/character_screen.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({ Key? key }) : super(key: key);

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  bool _showLoader = false;
  String _search = '';
  bool _isFiltered = false;

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
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Personajes'),
        actions: <Widget>[
          _isFiltered
          ? IconButton(
              onPressed: _removeFilter, 
              icon: Icon(Icons.filter_none)
            )
          : IconButton(
              onPressed:  _showFilter, 
              icon: Icon(Icons.filter_alt)
            )
        ],
      ),
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
              onTap: () => _goInfoCharacter(e),
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(150),
                              child: FadeInImage(
                                placeholder: AssetImage('assets/not_found.png'), 
                                image: NetworkImage(e.image),
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover
                              ),
                            ),
                          ],
                        ),
                        Text(
                          e.name, 
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                        Icon(Icons.touch_app),
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

  void _goInfoCharacter(Character character) async {
    String? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CharacterScreen(character: character,)
      )
    );
    if (result == 'yes') {
      _getCharacters();
    }
  }

  void _showFilter() {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text('Filtrar Personajes'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Escriba las primeras letras del personaje'),
              SizedBox(height: 10,),
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Criterio de busqueda...',
                  labelText: 'Buscar',
                  suffixIcon: Icon(Icons.search)
                ),
                onChanged: (value) {
                  _search = value;
                },
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(), 
              child: Text('Cancelar')
            ),
            TextButton(
              onPressed: () => _filter(), 
              child: Text('Filtrar')
            ),
          ],
        );
      }
    );
  }


  void _filter() {
    if (_search.isEmpty) {
      return;
    }

    List<Character> filteredList = [];
    
    for (var character in _characters) {
      if (character.name.toLowerCase().contains(_search.toLowerCase())) {
        filteredList.add(character);
      }
    }

    setState(() {
      _characters = filteredList;
      _isFiltered = true;
    });

    Navigator.of(context).pop();
  }

  void _removeFilter() {
    setState(() {
      _isFiltered = false;
    });
    _getCharacters();
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