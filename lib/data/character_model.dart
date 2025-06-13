// lib/models/character.dart
class Character {
  final String id;
  final String name;
  final String imageUrl;  // Per l'icon
  final String portrait;  // Per il portrait
  final String ingamePortrait;  // Per il ritratto in-game
  final String pathImage;
  final String pathName;
  final String element;
  final int rarity;
  final String faction;
  final bool isFavorite;

  const Character({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.portrait,
    required this.ingamePortrait,
    required this.pathImage,
    required this.pathName,
    required this.element,
    required this.rarity,
    required this.faction,
    this.isFavorite = false,
  });

  Character copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? portrait,
    String? ingamePortrait,
    String? pathImage,
    String? pathName,
    String? element,
    int? rarity,
    String? faction,
    bool? isFavorite,
  }) {
    return Character(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      portrait: portrait ?? this.portrait,
      ingamePortrait: ingamePortrait ?? this.ingamePortrait,
      pathImage: pathImage ?? this.pathImage,
      pathName: pathName ?? this.pathName,
      element: element ?? this.element,
      rarity: rarity ?? this.rarity,
      faction: faction ?? this.faction,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      imageUrl: json['icon'] ?? '',  // Icon per CharacterIconWidget
      portrait: json['portrait'] ?? '',  // Portrait per CharacterPortraitWidget
      ingamePortrait: json['ingame_portrait'] ?? '',  // In-game portrait
      pathImage: '', // Non abbiamo path image nel nuovo JSON
      pathName: json['path'] ?? '',
      element: json['element'] ?? '',
      rarity: json['rarity'] ?? 4,
      faction: json['faction'] ?? '',
      isFavorite: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': imageUrl,
      'portrait': portrait,
      'ingame_portrait': ingamePortrait,
      'pathImage': pathImage,
      'path': pathName,
      'element': element,
      'rarity': rarity,
      'faction': faction,
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
    return 'Character(id: $id, name: $name, pathName: $pathName, element: $element, rarity: $rarity, faction: $faction, isFavorite: $isFavorite, ingamePortrait: $ingamePortrait)';
  }
}