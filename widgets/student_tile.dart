import 'package:flutter/material.dart';
import '../models/student.dart';
import '../utils/app_colors.dart';

/// Custom Reusable Student Card / ListTile Widget.
/// Displays student avatar, name, ID chip, department, email, and arrow indicator.
class StudentTile extends StatelessWidget {
  final Student student;
  final VoidCallback onTap;

  const StudentTile({
    super.key,
    required this.student,
    required this.onTap,
  });

  /// Get department-specific theme color for badge & avatar background
  Color _getDepartmentColor(String dept) {
    switch (dept.toLowerCase()) {
      case 'software engineering':
        return AppColors.deptSE;
      case 'computer science':
        return AppColors.deptCS;
      case 'information technology':
        return AppColors.deptIT;
      default:
        return AppColors.accent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = _getDepartmentColor(student.department);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                // Avatar with initials
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: themeColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: themeColor.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      student.initials,
                      style: TextStyle(
                        color: themeColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // Main Info Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and Student ID Badge Row
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              student.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: themeColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              student.id,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: themeColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Department
                      Row(
                        children: [
                          const Icon(
                            Icons.school_outlined,
                            size: 14,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              student.department,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),

                      // Email
                      Row(
                        children: [
                          const Icon(
                            Icons.email_outlined,
                            size: 14,
                            color: AppColors.textLight,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              student.email,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textLight,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Trailing Action Arrow
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.inputFill,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
