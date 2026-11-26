import '../models/student.dart';

/// Sample initial dataset for demonstration.
/// Decoupled from UI so it can easily be swapped with a real database or REST API payload.
class StudentData {
  static final List<Student> initialStudents = [
    const Student(
      id: 'SE-001',
      name: 'Ahmed Ali',
      department: 'Software Engineering',
      email: 'ahmed.ali@example.com',
    ),
    const Student(
      id: 'SE-002',
      name: 'Usman Khan',
      department: 'Software Engineering',
      email: 'usman.khan@example.com',
    ),
    const Student(
      id: 'CS-003',
      name: 'Hamza Ahmed',
      department: 'Computer Science',
      email: 'hamza.ahmed@example.com',
    ),
    const Student(
      id: 'IT-004',
      name: 'Bilal Hussain',
      department: 'Information Technology',
      email: 'bilal.hussain@example.com',
    ),
    const Student(
      id: 'SE-005',
      name: 'Ayesha Noor',
      department: 'Software Engineering',
      email: 'ayesha.noor@example.com',
    ),
    const Student(
      id: 'CS-006',
      name: 'Fatima Zahra',
      department: 'Computer Science',
      email: 'fatima.zahra@example.com',
    ),
    const Student(
      id: 'IT-007',
      name: 'Zain Abbas',
      department: 'Information Technology',
      email: 'zain.abbas@example.com',
    ),
    const Student(
      id: 'SE-008',
      name: 'Hassan Raza',
      department: 'Software Engineering',
      email: 'hassan.raza@example.com',
    ),
    const Student(
      id: 'CS-009',
      name: 'Maryam Iqbal',
      department: 'Computer Science',
      email: 'maryam.iqbal@example.com',
    ),
    const Student(
      id: 'IT-010',
      name: 'Saad Malik',
      department: 'Information Technology',
      email: 'saad.malik@example.com',
    ),
  ];
}
