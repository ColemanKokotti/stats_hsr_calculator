// lib/models/character.dart
class Character {
  final String id;
  final String name;
  final String imageUrl;
  final String pathImage;
  final String pathName;
  final String element;
  final int rarity;
  final bool isFavorite;

  const Character({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.pathImage,
    required this.pathName,
    required this.element,
    required this.rarity,
    this.isFavorite = false,
  });

  Character copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? pathImage,
    String? pathName,
    String? element,
    int? rarity,
    bool? isFavorite,
  }) {
    return Character(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      pathImage: pathImage ?? this.pathImage,
      pathName: pathName ?? this.pathName,
      element: element ?? this.element,
      rarity: rarity ?? this.rarity,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      imageUrl: json['icon'] ?? json['portrait'] ?? '',
      pathImage: json['path']?['icon'] ?? '',
      pathName: json['path']?['name'] ?? '',
      element: json['element']?['name'] ?? '',
      rarity: json['rarity'] ?? 4,
      isFavorite: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'pathImage': pathImage,
      'pathName': pathName,
      'element': element,
      'rarity': rarity,
      'isFavorite': isFavorite,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Character && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Character(id: $id, name: $name, pathName: $pathName, element: $element, rarity: $rarity, isFavorite: $isFavorite)';
  }
}