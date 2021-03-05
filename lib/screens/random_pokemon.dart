import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:test_project/blocs/search_bloc.dart';
import 'package:test_project/models/responses.dart';
import 'package:test_project/screens/pokemon_search.dart';
import 'package:test_project/widgets/pokemon_card_widget.dart';

class RandomPokemonScreen extends StatefulWidget {
  @override
  _RandomPokemonScreenState createState() => _RandomPokemonScreenState();
}

class _RandomPokemonScreenState extends State<RandomPokemonScreen> {
  MarkersCollectionBloc pokemonSearchBloc = MarkersCollectionBloc();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Случайный покемошка"),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 100,
            child: Center(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(
                    flex: 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      pokemonSearchBloc.searchRandom();
                    },
                    child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Color(0xFF3399FF),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text(
                          "Получить",
                          style: TextStyle(fontSize: 16),
                        ))),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  StreamBuilder(
                    stream: pokemonSearchBloc.stream,
                    initialData: pokemonSearchBloc.defaultItem,
                    builder: (BuildContext context,
                        AsyncSnapshot<PokemonResponse> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data is PokemonResponseLoading) {
                          return SpinKitCircle(
                            color: Color(0xFF000066),
                            size: 50,
                          );
                        } else if (snapshot.data is PokemonResponseOK) {
                          return PokemonCardWidget(
                            pokemon: snapshot.data.pokemon,
                          );
                        } else if (snapshot.data is PokemonResponseWithError) {
                          return Text(snapshot.data.err,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 16));
                        }
                        return Container();
                      } else {
                        return Container();
                      }
                    },
                  ),
                  Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
