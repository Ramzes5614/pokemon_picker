import 'dart:convert';

import 'package:test_project/models/pokemon_model.dart';

class PokemonResponse {
  PokemonModel pokemon;
  String err;
  PokemonResponse({
    this.pokemon,
    this.err,
  });

  PokemonResponse.fromJson(var data)
      : this.pokemon = PokemonModel.fromJson(data),
        this.err = "";

  PokemonResponse.withErr(String err)
      : this.pokemon = null,
        this.err = err;
}

class PokemonResponseInitial extends PokemonResponse {}

class PokemonResponseLoading extends PokemonResponse {}

class PokemonResponseOK extends PokemonResponse {
  PokemonResponseOK(var data) : super.fromJson(data);
  PokemonResponseOK.fromPokemon(PokemonModel pokemon):super(pokemon: pokemon, err: "");
}

class PokemonResponseWithError extends PokemonResponse {
  PokemonResponseWithError(String err) : super.withErr(err);
}
