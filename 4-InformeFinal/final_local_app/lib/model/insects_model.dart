import 'dart:convert';

Map<String, Insects> insectsFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, Insects>(k, Insects.fromJson(v)));

String insectsToJson(Map<String, Insects> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Insects {
    Insects({
        required this.id,
        required this.fileName,
        required this.name,
        required this.availability,
        required this.price,
        required this.priceFlick,
        required this.catchPhrase,
        required this.museumPhrase,
        required this.imageUri,
        required this.iconUri,
        required this.altCatchPhrase,
    });

    int id;
    String fileName;
    Name name;
    Availability availability;
    int price;
    int priceFlick;
    String catchPhrase;
    String museumPhrase;
    String imageUri;
    String iconUri;
    List<String>? altCatchPhrase;

    factory Insects.fromJson(Map<String, dynamic> json) => Insects(
        id: json["id"],
        fileName: json["file-name"],
        name: Name.fromJson(json["name"]),
        availability: Availability.fromJson(json["availability"]),
        price: json["price"],
        priceFlick: json["price-flick"],
        catchPhrase: json["catch-phrase"],
        museumPhrase: json["museum-phrase"],
        imageUri: json["image_uri"],
        iconUri: json["icon_uri"],
        altCatchPhrase: json["alt-catch-phrase"] == null ? null : List<String>.from(json["alt-catch-phrase"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "file-name": fileName,
        "name": name.toJson(),
        "availability": availability.toJson(),
        "price": price,
        "price-flick": priceFlick,
        "catch-phrase": catchPhrase,
        "museum-phrase": museumPhrase,
        "image_uri": imageUri,
        "icon_uri": iconUri,
        "alt-catch-phrase": altCatchPhrase == null ? null : List<dynamic>.from(altCatchPhrase!.map((x) => x)),
    };
}

class Availability {
    Availability({
        required this.monthNorthern,
        required this.monthSouthern,
        required this.time,
        required this.isAllDay,
        required this.isAllYear,
        required this.location,
        required this.rarity,
        required this.monthArrayNorthern,
        required this.monthArraySouthern,
        required this.timeArray,
    });

    String monthNorthern;
    String monthSouthern;
    String time;
    bool isAllDay;
    bool isAllYear;
    String location;
    Rarity? rarity;
    List<int> monthArrayNorthern;
    List<int> monthArraySouthern;
    List<int> timeArray;

    factory Availability.fromJson(Map<String, dynamic> json) => Availability(
        monthNorthern: json["month-northern"],
        monthSouthern: json["month-southern"],
        time: json["time"],
        isAllDay: json["isAllDay"],
        isAllYear: json["isAllYear"],
        location: json["location"],
        rarity: rarityValues.map[json["rarity"]],
        monthArrayNorthern: List<int>.from(json["month-array-northern"].map((x) => x)),
        monthArraySouthern: List<int>.from(json["month-array-southern"].map((x) => x)),
        timeArray: List<int>.from(json["time-array"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "month-northern": monthNorthern,
        "month-southern": monthSouthern,
        "time": time,
        "isAllDay": isAllDay,
        "isAllYear": isAllYear,
        "location": location,
        "rarity": rarityValues.reverse[rarity],
        "month-array-northern": List<dynamic>.from(monthArrayNorthern.map((x) => x)),
        "month-array-southern": List<dynamic>.from(monthArraySouthern.map((x) => x)),
        "time-array": List<dynamic>.from(timeArray.map((x) => x)),
    };
}

enum Rarity { UNCOMMON, COMMON, RARE, ULTRA_RARE }

final rarityValues = EnumValues({
    "Common": Rarity.COMMON,
    "Rare": Rarity.RARE,
    "Ultra-rare": Rarity.ULTRA_RARE,
    "Uncommon": Rarity.UNCOMMON
});

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

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap ??= map.map((k, v) => MapEntry(v, k));
        return reverseMap!;
    }
}