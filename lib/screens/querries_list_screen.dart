import 'package:flutter/material.dart';
import 'package:test_project/models/pokemon_model.dart';
import 'package:test_project/repos/database.dart';
import 'package:test_project/screens/pokemon_view_screen.dart';

class QuerriesListScreen extends StatefulWidget {
  @override
  _QuerriesListScreenState createState() => _QuerriesListScreenState();
}

class _QuerriesListScreenState extends State<QuerriesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Мои запросы"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Center(
            child: FutureBuilder<List<PokemonModel>>(
                future: getList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                        itemBuilder: (BuildContext context, ind) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonViewScreen(pokemonModel: snapshot.data[ind])));
                            },
                               child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${snapshot.data[ind].id}"),
                                  Text("${snapshot.data[ind].name}"),
                                  Text("${snapshot.data[ind].image}"),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, ind) {
                          return Divider();
                        },
                        itemCount: snapshot.data.length);
                  } else {
                    return Container();
                  }
                })),
      ),
    );
  }

  Future<List<PokemonModel>> getList() async {
    List<PokemonModel> _list = await DBProvider.db.getAllClients();
    return _list;
  }
}
