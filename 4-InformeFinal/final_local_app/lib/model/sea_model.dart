import 'dart:convert';

Map<String, Sea> seaFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, Sea>(k, Sea.fromJson(v)));

String seaToJson(Map<String, Sea> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Sea {
  int id;
  String fileName;
  Name name;
  Availability availability;
  String speed;
  String shadow;
  int price;
  String catchPhrase;
  String imageUri;
  String iconUri;
  String museumPhrase;

  Sea(
      {required this.id,
      required this.fileName,
      required this.name,
      required this.availability,
      required this.speed,
      required this.shadow,
      required this.price,
      required this.catchPhrase,
      required this.imageUri,
      required this.iconUri,
      required this.museumPhrase});

   factory Sea.fromJson(Map<String, dynamic> json) => Sea(
    id: json['id'],
    fileName: json['file-name'],
    name: (json['name'] != null ? new Name.fromJson(json['name']) : null)!,
    availability : (json['availability'] != null
        ? new Availability.fromJson(json['availability'])
        : null)!,
    speed : json['speed'],
    shadow : json['shadow'],
    price : json['price'],
    catchPhrase : json['catch-phrase'],
    imageUri : json['image_uri'],
    iconUri : json['icon_uri'],
    museumPhrase : json['museum-phrase'],
   );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['file-name'] = this.fileName;
    if (this.name != null) {
      data['name'] = this.name.toJson();
    }
    if (this.availability != null) {
      data['availability'] = this.availability.toJson();
    }
    data['speed'] = this.speed;
    data['shadow'] = this.shadow;
    data['price'] = this.price;
    data['catch-phrase'] = this.catchPhrase;
    data['image_uri'] = this.imageUri;
    data['icon_uri'] = this.iconUri;
    data['museum-phrase'] = this.museumPhrase;
    return data;
  }
}

class Name {
  String nameUSen;
  String nameEUen;
  String nameEUnl;
  String nameEUde;
  String nameEUes;
  String nameUSes;
  String nameEUfr;
  String nameUSfr;
  String nameEUit;
  String nameCNzh;
  String nameTWzh;
  String nameJPja;
  String nameKRko;
  String nameEUru;

  Name(
      {required this.nameUSen,
      required this.nameEUen,
      required this.nameEUnl,
      required this.nameEUde,
      required this.nameEUes,
      required this.nameUSes,
      required this.nameEUfr,
      required this.nameUSfr,
      required this.nameEUit,
      required this.nameCNzh,
      required this.nameTWzh,
      required this.nameJPja,
      required this.nameKRko,
      required this.nameEUru});

  factory Name.fromJson(Map<String, dynamic> json) => Name(
    nameUSen: json['name-USen'],
    nameEUen: json['name-EUen'],
    nameEUnl: json['name-EUnl'],
    nameEUde: json['name-EUde'],
    nameEUes: json['name-EUes'],
    nameUSes: json['name-USes'],
    nameEUfr: json['name-EUfr'],
    nameUSfr: json['name-USfr'],
    nameEUit: json['name-EUit'],
    nameCNzh: json['name-CNzh'],
    nameTWzh: json['name-TWzh'],
    nameJPja: json['name-JPja'],
    nameKRko: json['name-KRko'],
    nameEUru: json['name-EUru'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name-USen'] = this.nameUSen;
    data['name-EUen'] = this.nameEUen;
    data['name-EUnl'] = this.nameEUnl;
    data['name-EUde'] = this.nameEUde;
    data['name-EUes'] = this.nameEUes;
    data['name-USes'] = this.nameUSes;
    data['name-EUfr'] = this.nameEUfr;
    data['name-USfr'] = this.nameUSfr;
    data['name-EUit'] = this.nameEUit;
    data['name-CNzh'] = this.nameCNzh;
    data['name-TWzh'] = this.nameTWzh;
    data['name-JPja'] = this.nameJPja;
    data['name-KRko'] = this.nameKRko;
    data['name-EUru'] = this.nameEUru;
    return data;
  }
}

class Availability {
  String monthNorthern;
  String monthSouthern;
  String time;
  bool isAllDay;
  bool isAllYear;
  List<int> monthArrayNorthern;
  List<int> monthArraySouthern;
  List<int> timeArray;

  Availability(
      {required this.monthNorthern,
      required this.monthSouthern,
      required this.time,
      required this.isAllDay,
      required this.isAllYear,
      required this.monthArrayNorthern,
      required this.monthArraySouthern,
      required this.timeArray});

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
    monthNorthern: json['month-northern'],
    monthSouthern: json['month-southern'],
    time: json['time'],
    isAllDay: json['isAllDay'],
    isAllYear: json['isAllYear'],
    monthArrayNorthern: json['month-array-northern'].cast<int>(),
    monthArraySouthern: json['month-array-southern'].cast<int>(),
    timeArray: json['time-array'].cast<int>(),
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month-northern'] = this.monthNorthern;
    data['month-southern'] = this.monthSouthern;
    data['time'] = this.time;
    data['isAllDay'] = this.isAllDay;
    data['isAllYear'] = this.isAllYear;
    data['month-array-northern'] = this.monthArrayNorthern;
    data['month-array-southern'] = this.monthArraySouthern;
    data['time-array'] = this.timeArray;
    return data;
  }
}