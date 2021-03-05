import 'dart:convert';

class AbilityModel {
  String name;
  String url;
  AbilityModel({
    this.name,
    this.url,
  });

  AbilityModel copyWith({
    String name,
    String url,
  }) {
    return AbilityModel(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
    };
  }

  factory AbilityModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AbilityModel(
      name: map['name'],
      url: map['url'],
    );
  }

  factory AbilityModel.fromMapJ(Map<String, dynamic> map) {
    if (map == null) return null;

    return AbilityModel(
      name: map['ability']['name'],
      url: map['ability']['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AbilityModel.fromJson(String source) =>
      AbilityModel.fromMapJ(json.decode(source));

  @override
  String toString() => 'AbilityModel(name: $name, url: $url)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AbilityModel && o.name == name && o.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}
