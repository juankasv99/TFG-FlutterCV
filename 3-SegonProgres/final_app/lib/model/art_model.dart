import 'dart:convert';

Map<String, Art> artFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, Art>(k, Art.fromJson(v)));

String artToJson(Map<String, Art> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Art {
  Art({
    required this.id,
    required this.fileName,
    required this.name,
    required this.hasFake,
    required this.buyPrice,
    required this.sellPrice,
    required this.imageUri,
    required this.artUri,
    required this.artFakeUri,
    required this.museumDesc
  });

  int id;
  String fileName;
  Name name;
  bool hasFake;
  int buyPrice;
  int sellPrice;
  String imageUri;
  String? artUri;
  String? artFakeUri;
  String? museumDesc;

  factory Art.fromJson(Map<String, dynamic> json) => Art(
    id: json["id"],
    fileName: json['file-name'],
    name: Name.fromJson(json["name"]),
    hasFake: json["hasFake"],
    buyPrice: json["buy-price"],
    sellPrice: json["sell-price"],
    imageUri: json["image_uri"],
    artUri: json["art_uri"] ?? "",
    artFakeUri: json["art_fake_uri"] ?? "",
    museumDesc: json["museum-desc"] ?? "",

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "file-name": fileName,
    "name": name.toJson(),
    "hasFake": hasFake,
    "buy-price": buyPrice,
    "sell-price": sellPrice,
    "image_uri": imageUri,
    "art_uri": artUri ?? "",
    "art_fake_uri": artFakeUri ?? "",
    "museum-desc": museumDesc ?? "",
  };
}

class Name {
    Name({
        required this.nameUSen,
        required this.nameEUen,
        required this.nameEUde,
        required this.nameEUes,
        required this.nameUSes,
        required this.nameEUfr,
        required this.nameUSfr,
        required this.nameEUit,
        required this.nameEUnl,
        required this.nameCNzh,
        required this.nameTWzh,
        required this.nameJPja,
        required this.nameKRko,
        required this.nameEUru,
    });

    String nameUSen;
    String nameEUen;
    String nameEUde;
    String nameEUes;
    String nameUSes;
    String nameEUfr;
    String nameUSfr;
    String nameEUit;
    String nameEUnl;
    String nameCNzh;
    String nameTWzh;
    String nameJPja;
    String nameKRko;
    String nameEUru;

    factory Name.fromJson(Map<String, dynamic> json) => Name(
        nameUSen: json["name-USen"],
        nameEUen: json["name-EUen"],
        nameEUde: json["name-EUde"],
        nameEUes: json["name-EUes"],
        nameUSes: json["name-USes"],
        nameEUfr: json["name-EUfr"],
        nameUSfr: json["name-USfr"],
        nameEUit: json["name-EUit"],
        nameEUnl: json["name-EUnl"],
        nameCNzh: json["name-CNzh"],
        nameTWzh: json["name-TWzh"],
        nameJPja: json["name-JPja"],
        nameKRko: json["name-KRko"],
        nameEUru: json["name-EUru"],
    );

    Map<String, dynamic> toJson() => {
        "name-USen": nameUSen,
        "name-EUen": nameEUen,
        "name-EUde": nameEUde,
        "name-EUes": nameEUes,
        "name-USes": nameUSes,
        "name-EUfr": nameEUfr,
        "name-USfr": nameUSfr,
        "name-EUit": nameEUit,
        "name-EUnl": nameEUnl,
        "name-CNzh": nameCNzh,
        "name-TWzh": nameTWzh,
        "name-JPja": nameJPja,
        "name-KRko": nameKRko,
        "name-EUru": nameEUru,
    };
}