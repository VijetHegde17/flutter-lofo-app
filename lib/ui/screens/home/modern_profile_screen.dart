import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../providers/auth_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/modern_widgets.dart';
import '../auth/modern_login_screen.dart';

/// Modern Profile screen with glassmorphism
class ModernProfileScreen extends ConsumerWidget {
  const ModernProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authServiceProvider).currentUser;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Modern App Bar with gradient
          SliverAppBar.large(
            floating: true,
            pinned: true,
            expandedHeight: 120,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Profile',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
              expandedTitleScale: 1.3,
            ),
          ),

          // Profile Content
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  // Profile Header
                  GlassContainer(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // Avatar
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              user?.email?.substring(0, 1).toUpperCase() ?? '?',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        )
                            .animate()
                            .scale(
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.elasticOut,
                            )
                            .fadeIn(),
                        const SizedBox(height: 20),

                        // Email
                        Text(
                          user?.email ?? 'Unknown User',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                          textAlign: TextAlign.center,
                        )
                            .animate()
                            .fadeIn(delay: const Duration(milliseconds: 200)),
                        const SizedBox(height: 8),

                        // User ID
                        Text(
                          'ID: ${user?.id.substring(0, 8) ?? 'N/A'}',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.6),
                                  ),
                        )
                            .animate()
                            .fadeIn(delay: const Duration(milliseconds: 300)),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn()
                      .slideY(begin: 0.2, duration: const Duration(milliseconds: 400)),
                  const SizedBox(height: 24),

                  // Menu Items
                  _MenuCard(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    subtitle: 'App preferences and configuration',
                    onTap: () {
                      // TODO: Navigate to settings
                    },
                  )
                      .animate()
                      .fadeIn(delay: const Duration(milliseconds: 400))
                      .slideX(begin: -0.2),
                  const SizedBox(height: 12),

                  _MenuCard(
                    icon: Icons.help_outline_rounded,
                    title: 'Help & Support',
                    subtitle: 'Get help or contact support',
                    onTap: () {
                      // TODO: Navigate to help
                    },
                  )
                      .animate()
                      .fadeIn(delay: const Duration(milliseconds: 500))
                      .slideX(begin: -0.2),
                  const SizedBox(height: 12),

                  _MenuCard(
                    icon: Icons.info_outline_rounded,
                    title: 'About',
                    subtitle: 'App version and information',
                    onTap: () {
                      showAboutDialog(
                        context: context,
                        applicationName: 'Lost & Found',
                        applicationVersion: '2.0.0',
                        applicationLegalese:
                            '© 2024 Lost & Found. All rights reserved.',
                      );
                    },
                  )
                      .animate()
                      .fadeIn(delay: const Duration(milliseconds: 600))
                      .slideX(begin: -0.2),
                  const SizedBox(height: 32),

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: GradientButton(
                      text: 'Logout',
                      icon: Icons.logout_rounded,
                      gradient: const LinearGradient(
                        colors: [AppColors.lostItemColor, Color(0xFFDC2626)],
                      ),
                      onPressed: () async {
                        await ref.read(authControllerProvider.notifier).signOut();
                        if (context.mounted) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (_) => const ModernLoginScreen()),
                            (route) => false,
                          );
                        }
                      },
                    ),
                  )
                      .animate()
                      .fadeIn(delay: const Duration(milliseconds: 700))
                      .scale(delay: const Duration(milliseconds: 700)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.6),
                            ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
