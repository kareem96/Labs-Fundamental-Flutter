

class Menu{
  String name;

  Menu({required this.name});

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(name: json['name']);
  Map<String, dynamic> toJson() => {
    'name': name,
  };
}

class Menus{
  List<Menu> foods;
  List<Menu> drinks;

  Menus({required this.foods, required this.drinks});
  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
      foods: List<Menu>.from(json['foods'].map((x) => Menu.fromJson(x))),
      drinks: List<Menu>.from(json['drinks'].map((x) => Menu.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'foods': List<dynamic>.from(foods.map((x) => x.toJson())),
    'drinks': List<dynamic>.from(drinks.map((x) => x.toJson())),
  };
}