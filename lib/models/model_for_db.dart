import 'dart:convert';

class ModelForDB {
  int id;
  String name;
  String image;
  ModelForDB({
    this.id,
    this.name,
    this.image,
  });

  ModelForDB copyWith({
    int id,
    String name,
    String image,
  }) {
    return ModelForDB(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory ModelForDB.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ModelForDB(
      id: map['id'],
      name: map['name'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelForDB.fromJson(String source) =>
      ModelForDB.fromMap(json.decode(source));

  @override
  String toString() => 'ModelForDB(id: $id, name: $name, image: $image)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ModelForDB && o.id == id && o.name == name && o.image == image;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ image.hashCode;
}
