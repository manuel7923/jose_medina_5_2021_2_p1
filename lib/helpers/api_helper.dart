import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rycky_and_morty_app/models/character.dart';
import 'package:rycky_and_morty_app/models/response.dart';
import 'constants.dart';

class ApiHelper {
  static Future<Response> getCharacters() async {
    var url = Uri.parse('${Constants.apiUrl}api/character/');
    var response = await http.get(
    url,
    headers: {
      'content-type' : 'application/json',
      'accept' : 'application/json'
    },
  );

    var body = response.body;

    if (response.statusCode >= 400) {
      return Response(isSuccess: false, message: body);
    }
    
    List<Character> list = [];
    var decodedJson = jsonDecode(body);
    
    if (decodedJson != null) {
      for (var item in decodedJson["results"]) {
        print(item);
          list.add(Character.fromJson(item));
      }
    }

    return Response(isSuccess: true, result: list);
  }
}