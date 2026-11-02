import 'package:almcq/localization/language_controller.dart';
import 'package:almcq/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User? _user;
  late TextEditingController _nameController;
  bool _isEditingName = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    _nameController = TextEditingController(text: _user?.displayName ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _updateDisplayName() async {
    if (_user == null || _nameController.text.trim().isEmpty) return;
    setState(() => _isSaving = true);
    try {
      await _user!.updateDisplayName(_nameController.text.trim());
      await _user!.reload();
      setState(() {
        _user = FirebaseAuth.instance.currentUser;
        _isEditingName = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Display name updated successfully!'),
            backgroundColor: AppTheme.success,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update name: $e'),
            backgroundColor: AppTheme.error,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _confirmSignOut() async {
    final shouldSignOut = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(context.tr('sign_out')),
        content: Text(context.tr('sign_out_confirm_msg')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.tr('cancel')),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.error,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text(context.tr('sign_out')),
          ),
        ],
      ),
    );

    if (shouldSignOut == true) {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: LanguageController.instance,
      builder: (context, child) {
        final currentLang = LanguageController.instance.currentLanguage;

        return Scaffold(
          backgroundColor: AppTheme.lightBackground,
          appBar: AppBar(
            title: Text(context.tr('student_profile')),
            actions: [
              IconButton(
                tooltip: context.tr('sign_out'),
                icon: const Icon(Icons.logout_rounded, color: AppTheme.error),
                onPressed: _confirmSignOut,
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                // User Header Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppTheme.lightCardBorder),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 46,
                            backgroundColor:
                                AppTheme.primaryColor.withValues(alpha: 0.1),
                            child: ClipOval(
                              child: _user?.photoURL != null &&
                                      _user!.photoURL!.isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: _user!.photoURL!,
                                      width: 92,
                                      height: 92,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.person,
                                              size: 46,
                                              color: AppTheme.primaryColor),
                                    )
                                  : const Icon(Icons.person,
                                      size: 46, color: AppTheme.primaryColor),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: AppTheme.success,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.check,
                                  size: 14, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Display Name editing
                      if (!_isEditingName) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _user?.displayName ?? context.tr('student'),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.lightTextPrimary,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit_outlined, size: 18),
                              color: AppTheme.lightTextSecondary,
                              onPressed: () {
                                setState(() => _isEditingName = true);
                              },
                            ),
                          ],
                        ),
                      ] else ...[
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _nameController,
                                autofocus: true,
                                decoration: const InputDecoration(
                                  labelText: 'Display Name',
                                  isDense: true,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (_isSaving)
                              const CircularProgressIndicator(strokeWidth: 2)
                            else ...[
                              IconButton(
                                icon: const Icon(Icons.check,
                                    color: AppTheme.success),
                                onPressed: _updateDisplayName,
                              ),
                              IconButton(
                                icon: const Icon(Icons.close,
                                    color: AppTheme.error),
                                onPressed: () {
                                  setState(() {
                                    _nameController.text =
                                        _user?.displayName ?? '';
                                    _isEditingName = false;
                                  });
                                },
                              ),
                            ],
                          ],
                        ),
                      ],

                      Text(
                        _user?.email ?? 'student@smartify.app',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.lightTextSecondary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          context.tr('al_candidate_badge'),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Study Statistics Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.lightCardBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr('study_overview'),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.lightTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _StatItem(
                            icon: Icons.checklist_rounded,
                            color: AppTheme.primaryColor,
                            value: '500+',
                            label: context.tr('mcq_bank'),
                          ),
                          _StatItem(
                            icon: Icons.auto_stories_rounded,
                            color: AppTheme.secondaryColor,
                            value: '12 Units',
                            label: context.tr('curriculum'),
                          ),
                          _StatItem(
                            icon: Icons.history_edu_rounded,
                            color: AppTheme.accentColor,
                            value: '2015-21',
                            label: context.tr('past_papers_stat'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // App Settings & Info Section
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.lightCardBorder),
                  ),
                  child: Column(
                    children: [
                      // Language Switcher Tile
                      ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.accentColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.translate_rounded,
                              color: AppTheme.accentColor),
                        ),
                        title: Text(context.tr('app_language_setting')),
                        subtitle: Text(
                          '${currentLang.flag}  ${currentLang.nativeName} (${currentLang.name})',
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded,
                            size: 16, color: AppTheme.lightTextSecondary),
                        onTap: () => showLanguageBottomSheet(context),
                      ),
                      const Divider(indent: 56),
                      ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.school_outlined,
                              color: AppTheme.primaryColor),
                        ),
                        title: Text(context.tr('examination_target')),
                        subtitle: Text(context.tr('sl_exam_desc')),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded,
                            size: 16, color: AppTheme.lightTextSecondary),
                        onTap: () {},
                      ),
                      const Divider(indent: 56),
                      ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color:
                                AppTheme.secondaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.info_outline_rounded,
                              color: AppTheme.secondaryColor),
                        ),
                        title: Text(context.tr('about_smartify')),
                        subtitle:
                            const Text('Version 2.0.0 • Trilingual Edition'),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded,
                            size: 16, color: AppTheme.lightTextSecondary),
                        onTap: () {
                          showAboutDialog(
                            context: context,
                            applicationName: context.tr('app_name'),
                            applicationVersion: '2.0.0 (Trilingual)',
                            applicationLegalese:
                                'Dedicated to helping Sri Lankan A/L students master ICT in English, Sinhala & Tamil.',
                            applicationIcon: Image.asset(
                              'assets/1024.png',
                              width: 48,
                              height: 48,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Sign out Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _confirmSignOut,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.error,
                      side: const BorderSide(color: AppTheme.error, width: 1.2),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.logout_rounded, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          context.tr('sign_out_account'),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  final String label;

  const _StatItem({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppTheme.lightTextPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              color: AppTheme.lightTextSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
