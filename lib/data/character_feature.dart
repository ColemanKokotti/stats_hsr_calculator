import 'dart:ui';

class ChararcterAssets {
  // Mappa per le icone degli elementi
  static const Map<String, String> elementIcons = {
    'fire': 'assets/icons/element_icons/fire_icon.png',
    'ice': 'assets/icons/element_icons/ice_icon.png',
    'lightning': 'assets/icons/element_icons/lightning_icon.png',
    'wind': 'assets/icons/element_icons/wind_icon.png',
    'physical': 'assets/icons/element_icons/physical_icon.png',
    'quantum': 'assets/icons/element_icons/quantum_icon.png',
    'imaginary': 'assets/icons/element_icons/imaginary_icon.png',
  };

  // Mappa per le icone dei path
  static const Map<String, String> pathIcons = {
    'destruction': 'assets/icons/path_icons/destruction_icon.png',
    'hunt': 'assets/icons/path_icons/hunt_icon.png',
    'erudition': 'assets/icons/path_icons/erudition_icon.png',
    'harmony': 'assets/icons/path_icons/harmony_icon.png',
    'nihility': 'assets/icons/path_icons/nihility_icon.png',
    'preservation': 'assets/icons/path_icons/preservation_icon.png',
    'abundance': 'assets/icons/path_icons/abundance_icon.png',
    'remembrance': 'assets/icons/path_icons/remembrance_icon.png'
  };

  // Colori per gli elementi (mantenuti per i bordi e gli effetti)
  static const Map<String, int> elementColors = {
    'fire': 0xFFdd571c,
    'ice': 0xFFfdf8ff,
    'lightning': 0xFF9e7bb3,
    'wind': 0xFF2e6f40,
    'physical': 0xFF657895,
    'quantum': 0xFF592693,
    'imaginary': 0xFFfebe00,
  };

  // Colori per i path
  static const Map<String, int> pathColors = {
    'destruction': 0xFFFF4757,
    'hunt': 0xFF00D2D3,
    'erudition': 0xFF9C88FF,
    'harmony': 0xFF7ED321,
    'nihility': 0xFF8E44AD,
    'preservation': 0xFFF39C12,
    'abundance': 0xFF27AE60,
    'remembrance': 0xFF74C0FC
  };

  // Metodi helper per ottenere il path dell'icona
  static String getElementIcon(String element) {
    return elementIcons[element.toLowerCase()] ?? elementIcons['physical']!;
  }

  static String getPathIcon(String path) {
    return pathIcons[path.toLowerCase()] ?? pathIcons['destruction']!;
  }

  // Metodi helper per ottenere i colori
  static Color getElementColor(String element) {
    final colorValue = elementColors[element.toLowerCase()] ?? elementColors['physical']!;
    return Color(colorValue);
  }

  static Color getPathColor(String path) {
    final colorValue = pathColors[path.toLowerCase()] ?? pathColors['destruction']!;
    return Color(colorValue);
  }

  // Metodo per verificare se un elemento esiste
  static bool hasElementIcon(String element) {
    return elementIcons.containsKey(element.toLowerCase());
  }

  // Metodo per verificare se un path esiste
  static bool hasPathIcon(String path) {
    return pathIcons.containsKey(path.toLowerCase());
  }

  // Lista di tutti gli elementi disponibili
  static List<String> get allElements => elementIcons.keys.toList();

  // Lista di tutti i path disponibili
  static List<String> get allPaths => pathIcons.keys.toList();
}