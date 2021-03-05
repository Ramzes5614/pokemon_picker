import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_project/models/pokemon_model.dart';
import 'package:test_project/repos/app_repo.dart';

class PokemonCardWidget extends StatelessWidget {
  PokemonCardWidget({
    Key key,
    @required this.pokemon,
  }) : super(key: key);

  final PokemonModel pokemon;
  final AppRepository _repo = AppRepository();

  @override
  Widget build(BuildContext context) {
    List<TextSpan> abilitiesList = pokemon.abilities
        .map((item) => TextSpan(children: [
              TextSpan(text: "  "),
              TextSpan(
                  text: '${item.ability.name}',
                  style: TextStyle(
                      color: Color(0xFF33CCCC),
                      fontSize: 16,
                      decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => {
                          _repo
                              .getAbilityInfo(item.ability.url)
                              .then((str) => showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      scrollable: true,
                                      //insetPadding: EdgeInsets.all(40),
                                      backgroundColor: Colors.white,
                                      titlePadding:
                                          EdgeInsets.symmetric(horizontal: 100),
                                      titleTextStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontFamily: 'Gilroy'),
                                      title: Text(
                                        item.ability.name,
                                      ),
                                      content: RichText(
                                        text: TextSpan(
                                            text: str,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: 'Gilroy')),
                                      ),
                                      actions: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF000066),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                              child: Text(
                                                "Ок",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontFamily: 'Gilroy'),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  }))
                        }),
              TextSpan(text: "  ")
            ]))
        .toList();
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "Имя: ",
                  style: TextStyle(color: Colors.black, fontSize: 16)),
              TextSpan(
                  text: pokemon.name,
                  style: TextStyle(color: Color(0xFF33CCCC), fontSize: 16)),
            ]),
          ),
          SizedBox(
            height: 10,
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: "Способности: ",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              TextSpan(children: abilitiesList)
            ]),
          ),
          SizedBox(
            height: 10,
          ),
          pokemon.sprites.other.dreamWorld.frontDefault == null
              ? Container()
              : SvgPicture.network(
                  pokemon.sprites.other.dreamWorld.frontDefault,
                  height: 400,
                )
        ],
      ),
    );
  }
}
