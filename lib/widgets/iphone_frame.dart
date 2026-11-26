import 'package:flutter/material.dart';

/// Responsive Mobile Screen Frame Wrapper.
/// - Automatically adapts: On wide screens (Desktop, Web, Tablets), it renders a sleek
///   mobile phone screen frame with status bar, notch, and home bar.
/// - On real mobile devices / narrow screens, it fills the screen natively.
class MobileScreenFrame extends StatelessWidget {
  final Widget child;
  final bool forceMobileFrame;

  const MobileScreenFrame({
    super.key,
    required this.child,
    this.forceMobileFrame = true,
  });

  // Target Mobile Screen Dimensions (iPhone 12 Pro Max / Pixel XL standard)
  static const double mobileWidth = 428.0;
  static const double mobileHeight = 926.0;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final isWideScreen = media.size.width > 500;

    // If running on actual mobile device or narrow screen (and not forced)
    if (!isWideScreen && !forceMobileFrame) {
      return child;
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Dark Slate Background
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Phone Header Label Tag
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.phone_android_rounded, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Mobile App Screen View (428 × 926)',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // Physical Mobile Phone Outer Frame
                Container(
                  width: mobileWidth,
                  height: mobileHeight,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(52),
                    border: Border.all(
                      color: const Color(0xFF334155), // Sleek Titanium Metallic Bezel
                      width: 12,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.65),
                        blurRadius: 40,
                        spreadRadius: 4,
                        offset: const Offset(0, 20),
                      ),
                      BoxShadow(
                        color: const Color(0xFF2563EB).withOpacity(0.15),
                        blurRadius: 60,
                        spreadRadius: -10,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Stack(
                      children: [
                        // Inner Scoped Mobile Screen Content
                        Positioned.fill(
                          child: MediaQuery(
                            data: media.copyWith(
                              size: const Size(mobileWidth, mobileHeight),
                              padding: const EdgeInsets.only(top: 44, bottom: 34),
                              devicePixelRatio: 3.0,
                            ),
                            child: child,
                          ),
                        ),

                        // Top Mobile Status Bar (Clock, Camera Notch, Battery)
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          height: 44,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 26),
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '9:41',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.signal_cellular_4_bar, color: Colors.white, size: 14),
                                    const SizedBox(width: 6),
                                    const Icon(Icons.wifi, color: Colors.white, size: 14),
                                    const SizedBox(width: 6),
                                    Container(
                                      width: 22,
                                      height: 11,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white, width: 1),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.all(1.5),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Camera Notch Cutout
                        Positioned(
                          top: 0,
                          left: (mobileWidth - 180) / 2 - 12,
                          child: Container(
                            width: 180,
                            height: 28,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF1E293B),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  width: 40,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF334155),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Bottom Mobile Home Indicator Bar
                        Positioned(
                          bottom: 8,
                          left: (mobileWidth - 140) / 2 - 12,
                          child: Container(
                            width: 140,
                            height: 4.5,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
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
