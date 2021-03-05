import 'package:flutter/material.dart';
import 'package:test_project/models/model_for_db.dart';
import 'package:test_project/models/pokemon_model.dart';
import 'package:test_project/repos/database.dart';

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
      body: Center(
          child: FutureBuilder<List<ModelForDB>>(
              future: getList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                      itemBuilder: (BuildContext context, ind) {
                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${snapshot.data[ind].id}"),
                              Text("${snapshot.data[ind].name}"),
                              Text("${snapshot.data[ind].image}"),
                            ],
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
    );
  }

  Future<List<ModelForDB>> getList() async {
    List<ModelForDB> _list = await DBProvider.db.getAllClients();
    return _list;
  }
}
