import 'package:almcq/localization/language_controller.dart';
import 'package:almcq/theme/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  String _errorMessage = '';
  bool _isLoading = false;

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: AppTheme.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() => _isLoading = false);
        return;
      }
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      final msg = e.message ?? 'Authentication failed. Please try again.';
      setState(() => _errorMessage = msg);
      _showErrorSnackBar(msg);
    } catch (e) {
      final msg = 'Failed to sign in: $e';
      setState(() => _errorMessage = msg);
      _showErrorSnackBar(msg);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: LanguageController.instance,
      builder: (context, child) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  AppTheme.primaryColor.withValues(alpha: 0.04),
                  AppTheme.primaryColor.withValues(alpha: 0.10),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  // Language Switcher top right
                  const Positioned(
                    top: 16,
                    right: 20,
                    child: LanguageSelectorButton(),
                  ),
                  Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 24),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 440),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 20),
                            // Brand Icon
                            Center(
                              child: Container(
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.primaryColor
                                          .withValues(alpha: 0.16),
                                      blurRadius: 24,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(10),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/1024.png',
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                      Icons.school_rounded,
                                      size: 55,
                                      color: AppTheme.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Title & Subtitle
                            Text(
                              context.tr('welcome_title'),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                                color: AppTheme.lightTextPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              context.tr('welcome_desc'),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 13.5,
                                color: AppTheme.lightTextSecondary,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Feature highlights
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: AppTheme.lightCardBorder),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Colors.black.withValues(alpha: 0.03),
                                    blurRadius: 16,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Column(
                                children: [
                                  _FeatureRow(
                                    icon: Icons.quiz_outlined,
                                    iconColor: AppTheme.primaryColor,
                                    title: 'Past Paper & Category MCQs',
                                    subtitle:
                                        'Practice with instant answer explanations',
                                  ),
                                  Divider(height: 24),
                                  _FeatureRow(
                                    icon: Icons.menu_book_rounded,
                                    iconColor: AppTheme.secondaryColor,
                                    title: 'Comprehensive Syllabus Lessons',
                                    subtitle:
                                        'All 12 Units clearly organized for revision',
                                  ),
                                  Divider(height: 24),
                                  _FeatureRow(
                                    icon: Icons.picture_as_pdf_outlined,
                                    iconColor: AppTheme.accentRose,
                                    title: 'Marking Schemes & Short Notes',
                                    subtitle:
                                        'Official marking points and cheatsheets',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Error Message Banner (if present)
                            if (_errorMessage.isNotEmpty) ...[
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppTheme.error
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppTheme.error
                                        .withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.info_outline,
                                        color: AppTheme.error, size: 20),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        _errorMessage,
                                        style: const TextStyle(
                                          color: AppTheme.error,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],

                            // Sign-in Button
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              child: _isLoading
                                  ? Center(
                                      child: LoadingAnimationWidget
                                          .staggeredDotsWave(
                                        color: AppTheme.primaryColor,
                                        size: 50,
                                      ),
                                    )
                                  : ElevatedButton(
                                      onPressed: _signInWithGoogle,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor:
                                            AppTheme.lightTextPrimary,
                                        elevation: 1,
                                        shadowColor: Colors.black
                                            .withValues(alpha: 0.15),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          side: const BorderSide(
                                            color: AppTheme.lightCardBorder,
                                            width: 1.2,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/google_logo.png',
                                            height: 24,
                                            errorBuilder: (context, error,
                                                    stackTrace) =>
                                                const Icon(
                                                    Icons.account_circle,
                                                    color:
                                                        AppTheme.primaryColor),
                                          ),
                                          const SizedBox(width: 14),
                                          Text(
                                            context.tr('continue_google'),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: AppTheme.lightTextPrimary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 24),

                            // Privacy Note
                            const Text(
                              'By continuing, you agree to our Terms of Service & Privacy Policy for educational use.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                color: AppTheme.lightTextSecondary,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const _FeatureRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.lightTextPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.lightTextSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
