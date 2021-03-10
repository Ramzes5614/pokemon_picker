
import 'dart:convert';

import 'species_model.dart';

class Ability {
  Ability({
    this.ability,
    this.isHidden,
    this.slot,
  });

  Species ability;
  bool isHidden;
  int slot;

  factory Ability.fromJson(String str) => Ability.fromMap(json.decode(str));

  Map toJson() => toMap();

  factory Ability.fromMap(Map<String, dynamic> json) => Ability(
        ability: Species.fromMap(json["ability"]),
        isHidden: json["is_hidden"],
        slot: json["slot"],
      );

  Map<String, dynamic> toMap() => {
        "ability": ability != null ? ability.toMap() : null,
        "is_hidden": isHidden,
        "slot": slot,
      };
}

