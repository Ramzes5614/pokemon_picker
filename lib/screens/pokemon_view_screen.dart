import 'package:flutter/material.dart';
import 'package:test_project/models/pokemon_model.dart';
import 'package:test_project/widgets/pokemon_card_widget.dart';

class PokemonViewScreen extends StatefulWidget {
  final PokemonModel pokemonModel;
  const PokemonViewScreen({
    Key key,
    @required this.pokemonModel,
  }) : super(key: key);
  @override
  _PokemonViewScreenState createState() => _PokemonViewScreenState();
}

class _PokemonViewScreenState extends State<PokemonViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Text(widget.pokemonModel.name),
      ),
      body: Column(
       children:[ 
         Spacer(),
         PokemonCardWidget(pokemon: widget.pokemonModel),
         Spacer()
         ]
      ),
    );
  }
}