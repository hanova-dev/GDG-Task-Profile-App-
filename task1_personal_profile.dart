// Task 1: Simple Personal Profile App — Hanan bin Saleh
// Setup: save your photo as assets/profile.jpg and add to pubspec.yaml:
//   flutter:
//     assets:
//       - assets/profile.jpg

import 'package:flutter/material.dart';

void main() => runApp(const PersonalProfileApp());

// ---------- App colours: olive, green, cream, light orange ----------
class AppColors {
  static const olive = Color(0xFF6B7A3A);
  static const darkOlive = Color(0xFF3F4A22);
  static const green = Color(0xFF4F7942);
  static const cream = Color(0xFFFAF6EC);
  static const offWhite = Color(0xFFFFFDF7);
  static const lightOrange = Color(0xFFF4B26B);
  static const paleOrange = Color(0xFFFFE8CC);
  static const text = Color(0xFF2F3A1F);
}

class PersonalProfileApp extends StatelessWidget {
  const PersonalProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hanan bin Saleh',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.cream,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.olive,
          primary: AppColors.olive,
          secondary: AppColors.lightOrange,
          surface: AppColors.offWhite,
        ),
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // ---- Your details ----
  static const String name = 'Hanan bin Saleh';
  static const String title = 'Software Engineering Student';
  static const String intro =
      'Final-year Software Engineering student at COMSATS University, Attock '
      'Campus. Member of the Google Developers team at COMSATS Attock and '
      'Media Team Co-Head of CHAS. Currently sharpening my Flutter app '
      'development skills.';
  static const String email = 'callmeabdulhanann@gmail.com';
  static const String phone = '+92135364610';
  static const String instagram = '@abdul_hanan_bin_saleh';
  static const List<String> skills = [
    'Flutter',
    'Dart',
    'Software Engineering',
    'UI Design',
    'Media & Content',
    'Team Leadership',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        backgroundColor: AppColors.olive,
        foregroundColor: AppColors.cream,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Profile picture with orange ring
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppColors.lightOrange, AppColors.green],
                ),
              ),
              child: const ProfilePhoto(size: 124),
            ),
            const SizedBox(height: 16),

            const Text(
              name,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              title,
              style: TextStyle(fontSize: 16, color: AppColors.green),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: const [
                RoleBadge(icon: Icons.groups, label: 'Google Developers — COMSATS Attock'),
                RoleBadge(icon: Icons.videocam, label: 'Media Team Co-Head, CHAS'),
              ],
            ),
            const SizedBox(height: 24),

            const SectionTitle(icon: Icons.person, title: 'About Me'),
            const SizedBox(height: 8),
            const Text(
              intro,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, height: 1.5, color: AppColors.text),
            ),
            const SizedBox(height: 24),

            const SectionTitle(icon: Icons.contact_mail, title: 'Contact'),
            const SizedBox(height: 8),
            const ContactRow(icon: Icons.email, text: email),
            const ContactRow(icon: Icons.phone, text: phone),
            const ContactRow(icon: Icons.camera_alt, text: instagram),
            const SizedBox(height: 24),

            const SectionTitle(icon: Icons.star, title: 'Skills'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: skills
                  .map((s) => Chip(
                        backgroundColor: AppColors.paleOrange,
                        side: BorderSide.none,
                        avatar: const Icon(Icons.check_circle,
                            size: 18, color: AppColors.green),
                        label: Text(s,
                            style: const TextStyle(color: AppColors.text)),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  foregroundColor: AppColors.cream,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.send),
                label: const Text('Contact Me', style: TextStyle(fontSize: 16)),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: AppColors.darkOlive,
                      content: Text('Email me at $email'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Circular crop of assets/profile.jpg, framed on the face.
/// Shows initials if the image hasn't been added yet.
class ProfilePhoto extends StatelessWidget {
  final double size;
  const ProfilePhoto({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipOval(
        child: OverflowBox(
          maxWidth: size * 2.6,
          maxHeight: size * 2.6 * 1200 / 896, // photo aspect ratio
          alignment: const Alignment(-0.36, -0.59),
          child: Image.asset(
            'assets/profile.jpg',
            fit: BoxFit.fill,
            errorBuilder: (_, __, ___) => Container(
              color: AppColors.olive,
              alignment: Alignment.center,
              child: const Text('HS',
                  style: TextStyle(
                      fontSize: 40,
                      color: AppColors.cream,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
    );
  }
}

class RoleBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  const RoleBadge({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.paleOrange,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.olive),
          const SizedBox(width: 6),
          Flexible(
            child: Text(label,
                style: const TextStyle(fontSize: 12.5, color: AppColors.text)),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  const SectionTitle({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: AppColors.olive),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.olive),
        ),
      ],
    );
  }
}

class ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const ContactRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: AppColors.lightOrange),
          const SizedBox(width: 10),
          Flexible(
            child: Text(text,
                style: const TextStyle(fontSize: 15, color: AppColors.text)),
          ),
        ],
      ),
    );
  }
}
