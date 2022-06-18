/*import 'dart:convert';

ResturantsModel welcomeFromJson(String str) =>
    ResturantsModel.fromJson(json.decode(str));

String welcomeToJson(ResturantsModel data) => json.encode(data.toJson());

class ResturantsModel {
  ResturantsModel(
      {required this.name,
      required this.image,
      required this.city,
      required this.catname,
      required this.itemname,
      required this.itemprice});

  String? name;
  String? image;
  String? city;

  String? catname;
  String? itemname;
  double? itemprice;

  factory ResturantsModel.fromJson(Map<String, dynamic> json) =>
      ResturantsModel(
          name: json["name"],
          image: json["image"],
          city: json["city"],
          catname: json["menu"][0]["catname"],
          itemname: json["menu"][0]["cat"]["itemname"],
          itemprice: json["menu"][0]["cat"]["itemprice"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "city": city,
        "catname": catname,
        "itemname": itemname,
        "itemprice": itemprice
      };
}*/
import 'dart:convert';

ResturantModel resturantModelFromJson(String str) =>
    ResturantModel.fromJson(json.decode(str));

String resturantModelToJson(ResturantModel data) => json.encode(data.toJson());

class ResturantModel {
  ResturantModel(
      {required this.name,
      required this.image,
      required this.city,
      required this.menu,
      required this.rating});

  String? name;
  String? image;
  String? city;
  int rating;
  List<Menu>? menu;

  factory ResturantModel.fromJson(Map<dynamic, dynamic> json) => ResturantModel(
        name: json["name"],
        image: json["image"],
        city: json["city"],
        rating: json["rating"],
        menu: List<Menu>.from(json["menu"].map((x) => Menu.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "name": name,
        "image": image,
        "city": city,
        "rating": rating,
        "menu": List<dynamic>.from(menu!.map((x) => x.toJson())),
      };
}

class Menu {
  Menu({
    this.catname,
    this.cat,
  });

  String? catname;
  List<Cat>? cat;

  factory Menu.fromJson(Map<dynamic, dynamic> json) => Menu(
        catname: json["catname"],
        cat: List<Cat>.from(json["cat"].map((x) => Cat.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "catname": catname,
        "cat": List<dynamic>.from(cat!.map((x) => x.toJson())),
      };
}

class Cat {
  Cat({
    this.itemname,
    this.itemprice,
  });

  String? itemname;
  int? itemprice;

  factory Cat.fromJson(Map<dynamic, dynamic> json) => Cat(
        itemname: json["itemname"],
        itemprice: json["itemprice"],
      );

  Map<dynamic, dynamic> toJson() => {
        "itemname": itemname,
        "itemprice": itemprice,
      };
}
