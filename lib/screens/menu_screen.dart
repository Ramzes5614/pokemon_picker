import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test_project/models/pokemon_model.dart';
import 'package:test_project/repos/database.dart';
import 'package:test_project/screens/pokemon_search.dart';
import 'package:test_project/screens/querries_list_screen.dart';
import 'package:test_project/screens/random_pokemon.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Меню"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(
                flex: 2,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PokemonSearchScreen()));
                },
                child: Container(
                    height: 50,
                    width: 240,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color(0xFF6600FF)),
                    child: Center(
                        child: Text(
                      "Поиск по имени",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ))),
              ),
              Spacer(
                flex: 1,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RandomPokemonScreen()));
                },
                child: Container(
                    height: 50,
                    width: 240,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color(0xFF9933FF)),
                    child: Center(
                      child: Text("Рандомный вывод",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    )),
              ),
              Spacer(
                flex: 1,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuerriesListScreen()));
                },
                child: Container(
                    height: 50,
                    width: 240,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color(0xFF9933FF)),
                    child: Center(
                      child: Text("Мои запросы",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    )),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
