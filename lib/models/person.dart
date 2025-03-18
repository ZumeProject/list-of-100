class Person {
  final String id;
  String name;
  Status status;
  
  Person({
    required this.id,
    required this.name,
    required this.status,
  });
  
  // Convert Person to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status.index,
    };
  }
  
  // Create Person from JSON
  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      name: json['name'],
      status: Status.values[json['status']],
    );
  }
  
  // Create a copy of Person with updated properties
  Person copyWith({
    String? name,
    Status? status,
  }) {
    return Person(
      id: id,
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }
}

enum Status {
  unbeliever,
  believer,
  unknown,
}

extension StatusExtension on Status {
  String get name {
    switch (this) {
      case Status.unbeliever:
        return 'Unbeliever';
      case Status.believer:
        return 'Believer';
      case Status.unknown:
        return 'Unknown';
    }
  }
} 