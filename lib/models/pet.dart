class Pet {
  final String id;
  final String name;
  final String type;
  final String breed;
  final String furColor;
  final DateTime? birthday;
  final String gender;
  final double? weight;
  final bool neutered;
  final String note;
  final String? avatarPath;

  Pet({
    required this.id,
    required this.name,
    required this.type,
    required this.breed,
    required this.furColor,
    this.birthday,
    required this.gender,
    this.weight,
    required this.neutered,
    required this.note,
    this.avatarPath,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'name': name,
      'type': type,
      'breed': breed,
      'furColor': furColor,
      'birthday': birthday?.toIso8601String(),
      'gender': gender,
      'weight': weight,
      'neutered': neutered,
      'note': note,
      'avatarPath': avatarPath,
    };
  }

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      breed: json['breed'] ?? '',
      furColor: json['furColor'] ?? '',
      birthday: json['birthday'] != null
          ? DateTime.parse(json['birthday'])
          : null,
      gender: json['gender'] ?? '',
      weight: json['weight'] != null
          ? (json['weight'] as num).toDouble()
          : null,
      neutered: json['neutered'] ?? false,
      note: json['note'] ?? '',
      avatarPath: json['avatarPath'],
    );
  }
}
