import 'package:rycky_and_morty_app/models/location.dart';
import 'package:rycky_and_morty_app/models/origin.dart';

class Character {
  int id = 0;
  String name = '';
  String status = '';
  String species = '';
  String type = '';
  String gender = '';
  List<Origin> origin = [];
  List<Location> location = [];
  String image = '';
  List<String> episode = [];
  String url = '';
  String created = '';

  Character({
      required this.id,
      required this.name,
      required this.status,
      required this.species,
      required this.type,
      required this.gender,
      required this.origin,
      required this.location,
      required this.image,
      required this.episode,
      required this.url,
      required this.created});

  Character.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> dataOri = new Map<String, dynamic>();
    final Map<String, dynamic> dataLoc = new Map<String, dynamic>();

    id = json['id'];
    name = json['name'];
    status = json['status'];
    species = json['species'];
    type = json['type'];
    gender = json['gender'];
    if (json['origin'] != null) {
      origin = [];
      List vari = [];
      json['origin'].forEach((k, v) {
        if (k == 'name') {
          dataOri['name'] = v;
        }
        if (k == 'url') {
          dataOri['url'] = v;
          origin.add(new Origin.fromJson(dataOri));
        }
      });
    }
    if (json['location'] != null) {
      location = [];
      json['location'].forEach((k, v) {
        if (k == 'name') {
          dataLoc['name'] = v;
        }
        if (k == 'url') {
          dataLoc['url'] = v;
          location.add(new Location.fromJson(dataLoc));
        }
      });
    }
    image = json['image'];
    episode = json['episode'].cast<String>();
    url = json['url'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['species'] = this.species;
    data['type'] = this.type;
    data['gender'] = this.gender;
    data['origin'] = this.origin.map((v) => v.toJson()).toList();
    data['location'] = this.location.map((v) => v.toJson()).toList();
    data['image'] = this.image;
    data['episode'] = this.episode;
    data['url'] = this.url;
    data['created'] = this.created;
    return data;
  }
}