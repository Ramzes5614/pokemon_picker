import 'dart:convert';

import 'ability_model.dart';

class PokemonModel {
  PokemonModel({
    this.abilities,
    this.id,
    this.name,
    this.image,
  });
  List<Ability> abilities;
  int id;
  String name;
  String image;

  factory PokemonModel.fromJson(String str) =>
      PokemonModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  String abilitiesToJson(){
    return json.encode(abilities);
  }

  factory PokemonModel.fromMap(Map<String, dynamic> jsonMap) => PokemonModel(
        abilities: List<Ability>.from(
            jsonMap["abilities"]?.map((x) => Ability.fromMap(x))),
        id: jsonMap["id"],
        name: jsonMap["name"],
        image: jsonMap["sprites"]["other"]["dream_world"]["front_default"],
      );

  factory PokemonModel.fromDB(Map<String, dynamic> jsonMap) { 
    var ab = json.decode(json.decode(jsonMap["abilities"]));
    return PokemonModel(
        abilities: List<Ability>.from(
            ab?.map((x) => Ability.fromMap(x))),
        id: jsonMap["id"],
        name: jsonMap["name"],
        image: jsonMap["image"],
      );}

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "image": image,
        "abilities": abilities != null ? jsonEncode(abilities) : null
      };
}
