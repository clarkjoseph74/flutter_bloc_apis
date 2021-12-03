import 'dart:convert';

class Character {
  int charId;
  String name;
  String nickname;
  String birthday;
  String image;
  String status;
  String portrayed;
  List<dynamic> appearance;
  List<dynamic> occupation;

  Character({
    required this.charId,
    required this.name,
    required this.nickname,
    required this.birthday,
    required this.image,
    required this.status,
    required this.portrayed,
    required this.appearance,
    required this.occupation,
  });

  Map<String, dynamic> toMap() {
    return {
      'char_id': charId,
      'name': name,
      'nickname': nickname,
      'birthday': birthday,
      'img': image,
      'status': status,
      'portrayed': portrayed,
      'appearance': appearance,
      'occupation': occupation,
    };
  }

  factory Character.fromMap(Map<String, dynamic> map) {
    return Character(
      charId: map['char_id'],
      name: map['name'],
      nickname: map['nickname'],
      birthday: map['birthday'],
      image: map['img'],
      status: map['status'],
      portrayed: map['portrayed'],
      appearance: List<dynamic>.from(map['appearance']),
      occupation: List<dynamic>.from(map['occupation']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Character.fromJson(String source) =>
      Character.fromMap(json.decode(source));
}
