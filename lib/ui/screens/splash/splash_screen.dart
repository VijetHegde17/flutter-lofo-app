import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../providers/auth_provider.dart';
import '../auth/modern_login_screen.dart';
import '../home/modern_home_screen.dart';

/// Modern Splash Screen with animated logo
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Wait for 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Check auth state and navigate
    final authState = await ref.read(authStateChangesProvider.future);
    
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          if (authState == null) {
            return const ModernLoginScreen();
          }
          return const ModernHomeScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Clean Logo (no checkerboard background)
              Image.asset(
                'assets/images/splash_logo.png',
                height: 200,
                width: 200,
                fit: BoxFit.contain,
              )
                  .animate()
                  .fadeIn(duration: const Duration(milliseconds: 800))
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1.0, 1.0),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeOutBack,
                  ),
              const SizedBox(height: 32),
              
              // App Name
              Text(
                'Lost & Found',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
              )
                  .animate(delay: const Duration(milliseconds: 400))
                  .fadeIn(duration: const Duration(milliseconds: 600))
                  .slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 8),
              
              Text(
                'Find what matters',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w400,
                    ),
              )
                  .animate(delay: const Duration(milliseconds: 600))
                  .fadeIn(duration: const Duration(milliseconds: 600)),
            ],
          ),
        ),
      ),
    );
  }
}
