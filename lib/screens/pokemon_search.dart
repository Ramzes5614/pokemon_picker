import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:test_project/blocs/search_bloc.dart';
import 'package:test_project/models/pokemon_model.dart';
import 'package:test_project/models/responses.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_project/repos/app_repo.dart';
import 'package:test_project/widgets/pokemon_card_widget.dart';

class PokemonSearchScreen extends StatefulWidget {
  @override
  _PokemonSearchScreenState createState() => _PokemonSearchScreenState();
}

class _PokemonSearchScreenState extends State<PokemonSearchScreen> {
  MarkersCollectionBloc pokemonSearchBloc = MarkersCollectionBloc();
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Поиск"),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 200,
                        child: TextField(
                          controller: _textEditingController,
                          decoration: InputDecoration(
                              hoverColor: Colors.black,
                              fillColor: Colors.black,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_textEditingController.text.length == 0) {
                            return;
                          }
                          pokemonSearchBloc
                              .searchByName(_textEditingController.text);
                        },
                        child: Container(
                            height: 50,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Color(0xFF3399FF),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                              "Поиск",
                              style: TextStyle(fontSize: 16),
                            ))),
                      )
                    ],
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
