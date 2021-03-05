import 'dart:convert';

class Species {
  String name;
  String url;
  Species({
    this.name,
    this.url,
  });

  Species copyWith({
    String name,
    String url,
  }) {
    return Species(
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

  factory Species.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Species(
      name: map['name'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Species.fromJson(String source) =>
      Species.fromMap(json.decode(source));

  @override
  String toString() => 'Species(name: $name, url: $url)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Species && o.name == name && o.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}
