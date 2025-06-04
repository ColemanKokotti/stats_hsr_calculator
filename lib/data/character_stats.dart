// lib/models/character_stats.dart
class CharacterStats {
  final String id;
  final String name;
  final int hp;
  final int atk;
  final int def;
  final int spd;
  final double critRate; // Percentuale di crit rate (es. 50.0 per 50%)
  final double critDmg; // Percentuale di crit damage (es. 100.0 per 100%)
  final int? ultCost; // Nullable perché alcuni personaggi potrebbero non avere ultimate cost

  const CharacterStats({
    required this.id,
    required this.name,
    required this.hp,
    required this.atk,
    required this.def,
    required this.spd,
    required this.critRate,
    required this.critDmg,
    this.ultCost,
  });

  CharacterStats copyWith({
    String? id,
    String? name,
    int? hp,
    int? atk,
    int? def,
    int? spd,
    double? critRate,
    double? critDmg,
    int? ultCost,
  }) {
    return CharacterStats(
      id: id ?? this.id,
      name: name ?? this.name,
      hp: hp ?? this.hp,
      atk: atk ?? this.atk,
      def: def ?? this.def,
      spd: spd ?? this.spd,
      critRate: critRate ?? this.critRate,
      critDmg: critDmg ?? this.critDmg,
      ultCost: ultCost ?? this.ultCost,
    );
  }

  factory CharacterStats.fromJson(Map<String, dynamic> json) {
    // Funzione helper per parsare stringhe numeriche
    int parseIntFromString(dynamic value, int defaultValue) {
      if (value == null) return defaultValue;
      if (value is int) return value;
      if (value is String) {
        if (value.isEmpty) return defaultValue;
        return int.tryParse(value) ?? defaultValue;
      }
      return defaultValue;
    }

    // Funzione helper per parsare valori double
    double parseDoubleFromString(dynamic value, double defaultValue) {
      if (value == null) return defaultValue;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) {
        if (value.isEmpty) return defaultValue;
        // Rimuovi il simbolo % se presente
        String cleanValue = value.replaceAll('%', '');
        return double.tryParse(cleanValue) ?? defaultValue;
      }
      return defaultValue;
    }

    // Funzione helper per parsare ultimate cost (nullable)
    int? parseUltCost(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is String) {
        if (value.isEmpty) return null;
        return int.tryParse(value);
      }
      return null;
    }

    return CharacterStats(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      hp: parseIntFromString(json['hp'], 0),
      atk: parseIntFromString(json['atk'], 0),
      def: parseIntFromString(json['def'], 0),
      spd: parseIntFromString(json['spd'], 0),
      critRate: parseDoubleFromString(json['crit_rate'], 5.0), // Default 5%
      critDmg: parseDoubleFromString(json['crit_dmg'], 50.0), // Default 50%
      ultCost: parseUltCost(json['ult_cost']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'hp': hp.toString(),
      'atk': atk.toString(),
      'def': def.toString(),
      'spd': spd.toString(),
      'crit_rate': critRate.toStringAsFixed(1),
      'crit_dmg': critDmg.toStringAsFixed(1),
      'ult_cost': ultCost?.toString() ?? '',
    };
  }

  // Metodi helper per ottenere statistiche formattate
  String get formattedHp => hp.toString();
  String get formattedAtk => atk.toString();
  String get formattedDef => def.toString();
  String get formattedSpd => spd.toString();
  String get formattedCritRate => '${critRate.toStringAsFixed(1)}%';
  String get formattedCritDmg => '${critDmg.toStringAsFixed(1)}%';
  String get formattedUltCost => ultCost?.toString() ?? 'N/A';

  // Metodo per calcolare il power totale (esempio)
  int get totalPower => hp + atk + def + spd;

  // Metodo per calcolare il damage effettivo considerando i crit
  double get effectiveDamage {
    // Formula: ATK * (1 + (CritRate/100) * (CritDmg/100))
    return atk * (1 + (critRate / 100) * (critDmg / 100));
  }

  // Metodo per ottenere la statistica più alta (escludendo i crit per semplicità)
  String get highestStat {
    final stats = {'HP': hp, 'ATK': atk, 'DEF': def, 'SPD': spd};
    final maxEntry = stats.entries.reduce((a, b) => a.value > b.value ? a : b);
    return maxEntry.key;
  }

  // Metodo per ottenere la statistica più bassa (escludendo i crit per semplicità)
  String get lowestStat {
    final stats = {'HP': hp, 'ATK': atk, 'DEF': def, 'SPD': spd};
    final minEntry = stats.entries.reduce((a, b) => a.value < b.value ? a : b);
    return minEntry.key;
  }

  // Metodo per verificare se il personaggio è bilanciato (nessuna stat troppo bassa)
  bool get isBalanced {
    const threshold = 50; // Soglia minima per considerare una statistica accettabile
    return hp >= threshold && atk >= threshold && def >= threshold && spd >= threshold;
  }

  // Metodo per verificare se ha buoni valori di crit
  bool get hasGoodCritStats {
    // Considera buoni i crit se rate >= 70% e damage >= 120%
    return critRate >= 70.0 && critDmg >= 120.0;
  }

  // Metodo per ottenere il tipo di build suggerito basato sulle statistiche
  String get suggestedBuildType {
    if (hp >= 180) return 'Tank/Support';
    if (atk >= 95 && hasGoodCritStats) return 'Crit DPS';
    if (atk >= 95) return 'DPS';
    if (spd >= 110) return 'Speed Support';
    if (def >= 80) return 'Tank';
    return 'Balanced';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CharacterStats && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'CharacterStats(id: $id, name: $name, hp: $hp, atk: $atk, def: $def, spd: $spd, critRate: $critRate%, critDmg: $critDmg%, ultCost: $ultCost)';
  }

  // Metodo per confrontare le statistiche con un altro personaggio
  Map<String, double> compareWith(CharacterStats other) {
    return {
      'hp': (hp - other.hp).toDouble(),
      'atk': (atk - other.atk).toDouble(),
      'def': (def - other.def).toDouble(),
      'spd': (spd - other.spd).toDouble(),
      'critRate': critRate - other.critRate,
      'critDmg': critDmg - other.critDmg,
    };
  }

  // Metodo per ottenere le statistiche come mappa
  Map<String, dynamic> get statsMap => {
    'HP': hp,
    'ATK': atk,
    'DEF': def,
    'SPD': spd,
    'CRIT Rate': critRate,
    'CRIT DMG': critDmg,
  };

  // Metodo per ottenere le statistiche normalizzate (0-100)
  Map<String, double> get normalizedStats {
    // Valori di riferimento per la normalizzazione
    const maxHp = 222.0; // Castorice ha il massimo HP
    const maxAtk = 105.0; // Dr. Ratio ha il massimo ATK
    const maxDef = 105.0; // Firefly ha il massimo DEF
    const maxSpd = 115.0; // Seele ha il massimo SPD
    const maxCritRate = 100.0; // Massimo teorico per crit rate
    const maxCritDmg = 200.0; // Massimo ragionevole per crit damage

    return {
      'HP': (hp / maxHp * 100).clamp(0, 100),
      'ATK': (atk / maxAtk * 100).clamp(0, 100),
      'DEF': (def / maxDef * 100).clamp(0, 100),
      'SPD': (spd / maxSpd * 100).clamp(0, 100),
      'CRIT Rate': (critRate / maxCritRate * 100).clamp(0, 100),
      'CRIT DMG': (critDmg / maxCritDmg * 100).clamp(0, 100),
    };
  }

  // Metodo per calcolare il crit value (rate * 2 + dmg)
  double get critValue => (critRate * 2) + critDmg;

  String get critRating {
    final cv = critValue;
    if (cv >= 200) return 'Excellent';
    if (cv >= 160) return 'Great';
    if (cv >= 120) return 'Good';
    if (cv >= 80) return 'Average';
    return 'Poor';
  }
}