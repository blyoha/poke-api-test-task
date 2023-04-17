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
}
