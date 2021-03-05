import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:test_project/models/model_for_db.dart';
import 'package:test_project/models/responses.dart';

import 'database.dart';

class AppRepository {
  String mainUrl = 'https://pokeapi.co/api/v2';

  Future<PokemonResponse> getPokemonById() async {
    int rnd = Random().nextInt(800);
    var response = _getByUrl(mainUrl + '/pokemon/$rnd');
    return response;
  }

  Future<PokemonResponse> getPokemonByName(String name) async {
    var response = _getByUrl(mainUrl + '/pokemon/' + name);
    return response;
  }

  Future<PokemonResponse> _getByUrl(String url) async {
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        PokemonResponse resp = PokemonResponseOK(response.body);
        await DBProvider.db.newQuerry(ModelForDB(
            id: resp.pokemon.id,
            name: resp.pokemon.name,
            image: resp.pokemon.sprites.other.dreamWorld.frontDefault));
        return resp;
      } else {
        throw Exception("Проблема с сетью");
      }
    } catch (error, traceback) {
      print("$error - $traceback");
      return PokemonResponseWithError(error.toString());
    }
  }

  Future<String> getAbilityInfo(String ability) async {
    try {
      var response = await http.get(ability);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data['effect_entries']);
        for (Map<String, dynamic> item in data['effect_entries']) {
          if (item['language']['name'] == 'en') {
            return item['effect'];
          }
        }
        return "";
      } else {
        throw Exception("Проблема с сетью");
      }
    } catch (error, traceback) {
      print("$error - $traceback");
      return "";
    }
  }
}
