import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/student_service.dart';
import '../utils/app_colors.dart';
import '../widgets/student_tile.dart';
import 'login_screen.dart';
import 'student_detail_screen.dart';

/// Main Admin Dashboard Screen containing Summary Cards, Real-time Search,
/// Dynamic ListTile ListView builder, and Logout dialog confirmation.
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final StudentService _studentService = StudentService();
  final TextEditingController _searchController = TextEditingController();

  List<Student> _allStudents = [];
  List<Student> _filteredStudents = [];
  bool _isLoading = true;
  String _selectedDepartmentFilter = 'All';

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Load students asynchronously from repository
  Future<void> _loadStudents() async {
    setState(() => _isLoading = true);
    final students = await _studentService.getStudents();
    if (!mounted) return;
    setState(() {
      _allStudents = students;
      _applyFilterAndSearch();
      _isLoading = false;
    });
  }

  /// Filter students based on search query and department chip selection
  void _applyFilterAndSearch() {
    final query = _searchController.text.trim().toLowerCase();
    
    setState(() {
      _filteredStudents = _allStudents.where((student) {
        // Department Chip Filter
        final deptMatch = _selectedDepartmentFilter == 'All' ||
            student.department.toLowerCase() == _selectedDepartmentFilter.toLowerCase();

        // Search Field Match (Name, ID, Department, Email)
        final searchMatch = query.isEmpty ||
            student.name.toLowerCase().contains(query) ||
            student.id.toLowerCase().contains(query) ||
            student.department.toLowerCase().contains(query) ||
            student.email.toLowerCase().contains(query);

        return deptMatch && searchMatch;
      }).toList();
    });
  }

  /// Logout confirmation dialog
  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.logout_rounded, color: AppColors.error),
            SizedBox(width: 8),
            Text('Logout Confirmation'),
          ],
        ),
        content: const Text(
          'Are you sure you want to log out of your admin session?',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logged out successfully.'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  /// Quick Add Student Dialog (for testing dynamic list updates)
  void _showAddStudentDialog() {
    final nameCtrl = TextEditingController();
    final idCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    String selectedDept = 'Software Engineering';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.person_add_outlined, color: AppColors.primary),
              SizedBox(width: 8),
              Text('Add New Student'),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: idCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Student ID (e.g. SE-011)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedDept,
                  decoration: const InputDecoration(
                    labelText: 'Department',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Software Engineering',
                      child: Text('Software Engineering'),
                    ),
                    DropdownMenuItem(
                      value: 'Computer Science',
                      child: Text('Computer Science'),
                    ),
                    DropdownMenuItem(
                      value: 'Information Technology',
                      child: Text('Information Technology'),
                    ),
                  ],
                  onChanged: (val) {
                    if (val != null) setDialogState(() => selectedDept = val);
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                if (nameCtrl.text.isEmpty || idCtrl.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all required fields.')),
                  );
                  return;
                }
                final newStudent = Student(
                  id: idCtrl.text.trim(),
                  name: nameCtrl.text.trim(),
                  department: selectedDept,
                  email: emailCtrl.text.trim().isEmpty
                      ? '${idCtrl.text.trim().toLowerCase()}@example.com'
                      : emailCtrl.text.trim(),
                );
                final success = await _studentService.addStudent(newStudent);
                if (!context.mounted) return;
                Navigator.pop(context);
                if (success) {
                  _loadStudents();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Student ${newStudent.name} added!'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Student ID already exists!'),
                      backgroundColor: AppColors.error,
                    ),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Count summary metrics
    final totalCount = _allStudents.length;
    final seCount = _allStudents.where((s) => s.department == 'Software Engineering').length;
    final csCount = _allStudents.where((s) => s.department == 'Computer Science').length;
    final itCount = _allStudents.where((s) => s.department == 'Information Technology').length;

    return Scaffold(
      backgroundColor: AppColors.background,

      // Modern AppBar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Row(
          children: [
            Icon(Icons.dashboard_outlined, size: 22),
            SizedBox(width: 10),
            Text(
              'Student Directory',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            tooltip: 'Profile',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logged in as Administrator (admin@gmail.com)'),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Logout',
            onPressed: _showLogoutConfirmation,
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddStudentDialog,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Student'),
      ),

      body: RefreshIndicator(
        onRefresh: _loadStudents,
        color: AppColors.accent,
        child: Column(
          children: [
            // Header Welcome & Summary Section (Dark Gradient Header)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome, Administrator 👋',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Manage student records, departments, and credentials',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textLight,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Summary Metric Cards Row
                  Row(
                    children: [
                      _buildMetricCard(
                        title: 'Total',
                        count: '$totalCount',
                        icon: Icons.people_outline,
                        badgeColor: AppColors.accent,
                      ),
                      const SizedBox(width: 8),
                      _buildMetricCard(
                        title: 'SE Dept',
                        count: '$seCount',
                        icon: Icons.code,
                        badgeColor: AppColors.deptSE,
                      ),
                      const SizedBox(width: 8),
                      _buildMetricCard(
                        title: 'CS Dept',
                        count: '$csCount',
                        icon: Icons.computer,
                        badgeColor: AppColors.deptCS,
                      ),
                      const SizedBox(width: 8),
                      _buildMetricCard(
                        title: 'IT Dept',
                        count: '$itCount',
                        icon: Icons.memory,
                        badgeColor: AppColors.deptIT,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Search Bar Component
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _searchController,
                onChanged: (val) => _applyFilterAndSearch(),
                style: const TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  hintText: 'Search by Name, ID (e.g. SE-001) or Dept...',
                  hintStyle: const TextStyle(color: AppColors.textLight, fontSize: 13.5),
                  prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: AppColors.textSecondary),
                          onPressed: () {
                            _searchController.clear();
                            _applyFilterAndSearch();
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: AppColors.surface,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: AppColors.accent, width: 2),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Filter Chips Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  _buildFilterChip('All'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Software Engineering'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Computer Science'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Information Technology'),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // ListView Builder / Dynamic ListTile Section
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: AppColors.accent),
                    )
                  : _filteredStudents.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          padding: const EdgeInsets.only(bottom: 80, top: 4),
                          itemCount: _filteredStudents.length,
                          itemBuilder: (context, index) {
                            final student = _filteredStudents[index];
                            return StudentTile(
                              student: student,
                              onTap: () async {
                                final refreshed = await Navigator.push<bool>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StudentDetailScreen(
                                      student: student,
                                    ),
                                  ),
                                );
                                if (refreshed == true) {
                                  _loadStudents();
                                }
                              },
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  /// Metric Card Widget for Header Summary
  Widget _buildMetricCard({
    required String title,
    required String count,
    required IconData icon,
    required Color badgeColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 14, color: badgeColor),
                const SizedBox(width: 4),
                Text(
                  count,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: TextStyle(
                fontSize: 10.5,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  /// Department Filter Chip Widget
  Widget _buildFilterChip(String label) {
    final isSelected = _selectedDepartmentFilter == label;
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.white : AppColors.textPrimary,
        ),
      ),
      selected: isSelected,
      selectedColor: AppColors.primary,
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? AppColors.primary : AppColors.border,
        ),
      ),
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedDepartmentFilter = label;
            _applyFilterAndSearch();
          });
        }
      },
    );
  }

  /// Empty State Widget when search results are empty
  Widget _buildEmptyState() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppColors.inputFill,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.search_off_rounded,
                size: 54,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No Students Found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'We could not find any student matching your search or department criteria.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.accent),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.refresh_rounded, color: AppColors.accent),
              label: const Text(
                'Clear Search & Filters',
                style: TextStyle(color: AppColors.accent),
              ),
              onPressed: () {
                setState(() {
                  _searchController.clear();
                  _selectedDepartmentFilter = 'All';
                  _applyFilterAndSearch();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
