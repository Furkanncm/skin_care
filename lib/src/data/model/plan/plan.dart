import 'package:bloc_clean_architecture/src/data/model/cosmetic/cosmetic.dart';

class Plan {
  final String date;
  final RoutinePart? morning;
  final RoutinePart? evening;

  Plan({required this.date, this.morning, this.evening});

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        date: json['date'] as String,
        morning: json['morning'] != null ? RoutinePart.fromJson(json['morning']) : null,
        evening: json['evening'] != null ? RoutinePart.fromJson(json['evening']) : null,
      );

  Map<String, dynamic> toJson() => {
        'date': date,
        'morning': morning?.toJson(),
        'evening': evening?.toJson(),
      };
}

class RoutinePart {
  final List<Cosmetic> cosmetics;
  RoutinePart({required this.cosmetics});

  factory RoutinePart.fromJson(Map<String, dynamic> json) => RoutinePart(
        cosmetics: (json['cosmetics'] as List<dynamic>).map((e) => Cosmetic.fromJson(e as Map<String, dynamic>)).toList(),
      );
  Map<String, dynamic> toJson() => {
        'cosmetics': cosmetics.map((e) => e.toJson()).toList(),
      };
}
