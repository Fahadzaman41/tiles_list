import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'utils/app_colors.dart';
import 'widgets/iphone_frame.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const StudentManagementApp());
}

/// Root Application Widget configured with Material Design 3 and Navy Theme Palette.
/// Wrapped with [MobileScreenFrame] for an authentic mobile screen experience on all devices.
class StudentManagementApp extends StatelessWidget {
  final bool enableMobileFrame;

  const StudentManagementApp({
    super.key,
    this.enableMobileFrame = true, // Enables realistic mobile phone screen frame view
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduManager Student Portal - Mobile Screen Interface',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.accent,
          surface: AppColors.surface,
          error: AppColors.error,
        ),
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
        fontFamily: 'Roboto',
      ),
      builder: (context, child) {
        if (child == null) return const SizedBox.shrink();
        return enableMobileFrame
            ? MobileScreenFrame(child: child)
            : child;
      },
      home: const LoginScreen(),
    );
  }
}
