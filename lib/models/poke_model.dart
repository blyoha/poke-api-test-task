const String tablePoke = "poke";

class PokeFields {
  static const List<String> values = [
    id,
    name,
    height,
    weight,
    abilities,
    forms,
    image,
  ];

  static const String id = "_id";
  static const String name = "name";
  static const String height = "height";
  static const String weight = "width";
  static const String abilities = "abilities";
  static const String forms = "forms";
  static const String image = "image";
}

class PokeModel {
  final int id;
  final String name;
  final int height;
  final int weight;
  final List abilities;
  final List forms;
  final String image;

  PokeModel({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.abilities,
    required this.forms,
    required this.image,
  });

  factory PokeModel.fromJson(Map<String, dynamic> json) {
    final abilities =
        json["abilities"].map((e) => e["ability"]["name"]).toList();

    final forms = json["forms"].map((e) => e["name"]).toList();

    final String image =
        json["sprites"]["other"]["official-artwork"]["front_default"];

    return PokeModel(
      id: json["id"],
      name: json["name"],
      height: json["height"],
      weight: json["weight"],
      abilities: abilities,
      forms: forms,
      image: image,
    );
  }

  factory PokeModel.fromDB(Map<String, dynamic> data) {
    final List abilities = data[PokeFields.abilities]
        .replaceAll("[", "")
        .replaceAll("]", "")
        .split(",");
    final List forms = data[PokeFields.forms]
        .replaceAll("[", "")
        .replaceAll("]", "")
        .split(",");

    return PokeModel(
      id: data[PokeFields.id] as int,
      name: data[PokeFields.name] as String,
      height: data[PokeFields.height],
      weight: data[PokeFields.weight],
      abilities: abilities,
      forms: forms,
      image: data[PokeFields.image] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      PokeFields.id: id,
      PokeFields.name: name,
      PokeFields.height: height,
      PokeFields.weight: weight,
      PokeFields.abilities: abilities.toString(),
      PokeFields.forms: forms.toString(),
      PokeFields.image: image,
    };
  }
}
