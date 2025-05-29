// lib/models/character.dart
class Character {
  final String id;
  final String name;
  final String imageUrl;  // Per l'icon
  final String portrait;  // Per il portrait
  final String pathImage;
  final String pathName;
  final String element;
  final int rarity;
  final bool isFavorite;

  const Character({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.portrait,
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
    String? portrait,
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
      portrait: portrait ?? this.portrait,
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
      imageUrl: json['icon'] ?? '',  // Icon per CharacterIconWidget
      portrait: json['portrait'] ?? '',  // Portrait per CharacterPortraitWidget
      pathImage: '', // Non abbiamo path image nel nuovo JSON
      pathName: json['path'] ?? '',
      element: json['element'] ?? '',
      rarity: json['rarity'] ?? 4,
      isFavorite: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': imageUrl,  // Salva come icon
      'portrait': portrait,  // Salva come portrait
      'pathImage': pathImage,
      'path': pathName,  // Salva come path
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