import 'dart:convert';

/// Data model representing a Student entity.
/// Includes serialization methods (`toMap`, `fromMap`, `toJson`, `fromJson`)
/// and utility getters for database compatibility.
class Student {
  final String id;
  final String name;
  final String department;
  final String email;
  final String? avatarUrl;

  const Student({
    required this.id,
    required this.name,
    required this.department,
    required this.email,
    this.avatarUrl,
  });

  /// Get initials for avatar display (e.g. "Ahmed Ali" -> "AA")
  String get initials {
    if (name.trim().isEmpty) return "ST";
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return "${parts[0][0]}${parts[1][0]}".toUpperCase();
    } else if (parts[0].length >= 2) {
      return parts[0].substring(0, 2).toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  /// Create a copy of Student with modified fields (useful for updates)
  Student copyWith({
    String? id,
    String? name,
    String? department,
    String? email,
    String? avatarUrl,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      department: department ?? this.department,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  /// Convert Student instance to Map for Database / API serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'department': department,
      'email': email,
      'avatarUrl': avatarUrl,
    };
  }

  /// Factory constructor to create a Student instance from a Map (Database / API)
  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      department: map['department'] ?? '',
      email: map['email'] ?? '',
      avatarUrl: map['avatarUrl'],
    );
  }

  /// Convert to JSON string
  String toJson() => json.encode(toMap());

  /// Factory to construct from JSON string
  factory Student.fromJson(String source) => Student.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Student(id: $id, name: $name, department: $department, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Student && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
