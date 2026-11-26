import '../data/student_data.dart';
import '../models/student.dart';

/// Repository/Service layer responsible for Student CRUD operations & Search.
/// Uses Future-based async signature to allow seamless migration to SQLite, Firebase, or REST API.
class StudentService {
  // Singleton pattern for centralized memory store during demo
  static final StudentService _instance = StudentService._internal();
  factory StudentService() => _instance;
  StudentService._internal();

  // In-memory list initialized with dummy student records
  final List<Student> _students = List.from(StudentData.initialStudents);

  /// Fetch all students
  /// [Database Future]: Replace with `await _db.query('students')` or API call tomorrow
  Future<List<Student>> getStudents() async {
    // Simulated network/DB latency delay (can be removed or kept for realistic UX)
    await Future.delayed(const Duration(milliseconds: 200));
    return List.unmodifiable(_students);
  }

  /// Get student by ID
  Future<Student?> getStudentById(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      return _students.firstWhere((s) => s.id.toLowerCase() == id.toLowerCase());
    } catch (_) {
      return null;
    }
  }

  /// Search students dynamically by Name, ID, or Department
  Future<List<Student>> searchStudents(String query) async {
    if (query.trim().isEmpty) {
      return getStudents();
    }
    
    final cleanQuery = query.trim().toLowerCase();
    return _students.where((student) {
      final nameMatch = student.name.toLowerCase().contains(cleanQuery);
      final idMatch = student.id.toLowerCase().contains(cleanQuery);
      final deptMatch = student.department.toLowerCase().contains(cleanQuery);
      final emailMatch = student.email.toLowerCase().contains(cleanQuery);
      return nameMatch || idMatch || deptMatch || emailMatch;
    }).toList();
  }

  /// Add a new student record
  Future<bool> addStudent(Student student) async {
    await Future.delayed(const Duration(milliseconds: 200));
    // Check for duplicate ID
    if (_students.any((s) => s.id.toLowerCase() == student.id.toLowerCase())) {
      return false;
    }
    _students.insert(0, student);
    return true;
  }

  /// Update an existing student record
  Future<bool> updateStudent(Student student) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _students.indexWhere((s) => s.id == student.id);
    if (index != -1) {
      _students[index] = student;
      return true;
    }
    return false;
  }

  /// Delete a student by ID
  Future<bool> deleteStudent(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final initialLength = _students.length;
    _students.removeWhere((s) => s.id == id);
    return _students.length < initialLength;
  }
}
