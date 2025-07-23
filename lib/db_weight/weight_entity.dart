import 'dart:convert';

class WeightEntity {
  int id;
  DateTime createdTime;
  int currentWeight;
  List<int> list;

  WeightEntity({
    required this.id,
    required this.createdTime,
    required this.currentWeight,
    required this.list,
  });

  factory WeightEntity.fromJson(Map<String, dynamic> json) {
    return WeightEntity(
      id: json['id'],
      createdTime: DateTime.parse(json['createdTime']),
      currentWeight: json['currentWeight'],
      list: List<int>.from(jsonDecode(json['list'])),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdTime': createdTime.toIso8601String(),
      'currentWeight': currentWeight,
      'list': jsonEncode(list),
    };
  }

  String get completionDegree {
    return '${100*list.length~/7}%';
  }
}