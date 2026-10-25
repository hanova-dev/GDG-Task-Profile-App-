// main.dart — Hanan bin Saleh: Profile (Task 1) + Portfolio (Task 2)
// Switch between the two screens with the bottom navigation bar.
// Requires assets/profile.png listed in pubspec.yaml.

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const MainShell(),
    );
  }
}

/// Holds both task screens and a bottom navigation bar.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  static const _screens = [
    ProfileScreen(), // Task 1
    HomeScreen(), // Task 2
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        backgroundColor: AppColors.offWhite,
        indicatorColor: AppColors.paleOrange,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.person_outline, color: AppColors.olive),
            selectedIcon: Icon(Icons.person, color: AppColors.darkOlive),
            label: 'Profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.work_outline, color: AppColors.olive),
            selectedIcon: Icon(Icons.work, color: AppColors.darkOlive),
            label: 'Portfolio',
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// TASK 1 — Personal Profile screen
// =====================================================================

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

// =====================================================================
// TASK 2 — Portfolio screen + shared colours/widgets
// =====================================================================

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
  static const subtext = Color(0xFF6E7560);
}

class Skill {
  final String name;
  final IconData icon;
  final double level; // 0.0 – 1.0
  const Skill(this.name, this.icon, this.level);
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // ---- Your details ----
  static const String name = 'Hanan bin Saleh';
  static const String profession = 'Software Engineering Student · Flutter Developer';
  static const String about =
      'I am a final-year Software Engineering student at COMSATS University, '
      'Attock Campus, and part of the Google Developers team there. I also '
      'serve as Media Team Co-Head of CHAS, where I help plan and produce '
      'content for events. Right now I am focused on building my Flutter app '
      'development skills and turning ideas into clean, useful mobile apps.';
  static const String email = 'callmeabdulhanann@gmail.com';
  static const String phone = '+92135364610';
  static const String instagram = '@abdul_hanan_bin_saleh';

  static const List<Skill> skills = [
    Skill('Flutter', Icons.phone_android, 0.75),
    Skill('Dart', Icons.code, 0.75),
    Skill('Software Engineering', Icons.account_tree, 0.8),
    Skill('UI / UX Design', Icons.brush, 0.7),
    Skill('Media & Content', Icons.videocam, 0.85),
    Skill('Team Leadership', Icons.groups, 0.8),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ---------- Header ----------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 60, bottom: 28, left: 16, right: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.darkOlive, AppColors.olive, AppColors.green],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.lightOrange,
                      shape: BoxShape.circle,
                    ),
                    child: const ProfilePhoto(size: 120),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    name,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.cream,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.school_outlined, color: AppColors.paleOrange, size: 18),
                      SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          profession,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14.5, color: AppColors.paleOrange),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Highlights row
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      StatItem(value: 'Final Year', label: 'Software Eng.'),
                      StatItem(value: 'GDG', label: 'COMSATS Attock'),
                      StatItem(value: 'Co-Head', label: 'CHAS Media'),
                    ],
                  ),
                ],
              ),
            ),

            // ---------- About ----------
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: SectionCard(
                icon: Icons.person_outline,
                title: 'About Me',
                child: Text(
                  about,
                  style: TextStyle(fontSize: 15, height: 1.55, color: AppColors.text),
                ),
              ),
            ),

            // ---------- Roles ----------
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: SectionCard(
                icon: Icons.workspace_premium_outlined,
                title: 'Roles',
                child: Column(
                  children: [
                    RoleRow(
                      icon: Icons.groups,
                      role: 'Team Member',
                      org: 'Google Developers — COMSATS Attock',
                    ),
                    RoleRow(
                      icon: Icons.videocam,
                      role: 'Media Team Co-Head',
                      org: 'CHAS',
                    ),
                  ],
                ),
              ),
            ),

            // ---------- Skills ----------
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: SectionCard(
                icon: Icons.star_outline,
                title: 'Skills',
                child: Column(
                  children: skills.map((s) => SkillRow(skill: s)).toList(),
                ),
              ),
            ),

            // ---------- Contact button ----------
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightOrange,
                    foregroundColor: AppColors.darkOlive,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Icons.mail_outline),
                  label: const Text('Contact Me',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  onPressed: () => _showContactSheet(context),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  void _showContactSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.offWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Get in touch',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkOlive)),
            SizedBox(height: 16),
            ContactTile(icon: Icons.email, label: 'Email', value: email),
            ContactTile(icon: Icons.phone, label: 'Phone', value: phone),
            ContactTile(icon: Icons.camera_alt, label: 'Instagram', value: instagram),
          ],
        ),
      ),
    );
  }
}

// ---------- Reusable widgets ----------

/// Circular crop of assets/profile.png, framed on the face.
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
            'assets/profile.png',
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

class StatItem extends StatelessWidget {
  final String value;
  final String label;
  const StatItem({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.lightOrange)),
        const SizedBox(height: 2),
        Text(label,
            style: const TextStyle(fontSize: 12, color: AppColors.cream)),
      ],
    );
  }
}

class SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;
  const SectionCard(
      {super.key, required this.icon, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: AppColors.offWhite,
      shadowColor: AppColors.olive.withAlpha(60),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.paleOrange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: AppColors.olive, size: 20),
                ),
                const SizedBox(width: 10),
                Text(title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkOlive)),
              ],
            ),
            Divider(height: 24, color: AppColors.olive.withAlpha(50)),
            child,
          ],
        ),
      ),
    );
  }
}

class RoleRow extends StatelessWidget {
  final IconData icon;
  final String role;
  final String org;
  const RoleRow({super.key, required this.icon, required this.role, required this.org});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.green.withAlpha(30),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: AppColors.green),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(role,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text)),
                Text(org,
                    style: const TextStyle(fontSize: 13, color: AppColors.subtext)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SkillRow extends StatelessWidget {
  final Skill skill;
  const SkillRow({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.paleOrange,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(skill.icon, size: 20, color: AppColors.olive),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(skill.name,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.text)),
                    Text('${(skill.level * 100).round()}%',
                        style: const TextStyle(color: AppColors.subtext)),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: skill.level,
                    minHeight: 6,
                    color: AppColors.green,
                    backgroundColor: AppColors.paleOrange,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ContactTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const ContactTile(
      {super.key, required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppColors.paleOrange,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.olive, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(fontSize: 12, color: AppColors.subtext)),
                Text(value,
                    style: const TextStyle(fontSize: 15, color: AppColors.text)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
