import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../widgets/modern_widgets.dart';
import 'modern_lost_items_screen.dart';
import 'modern_found_items_screen.dart';
import 'modern_add_item_screen.dart';
import 'modern_profile_screen.dart';

/// Modern home screen with animated tab bar
class ModernHomeScreen extends StatefulWidget {
  const ModernHomeScreen({super.key});

  @override
  State<ModernHomeScreen> createState() => _ModernHomeScreenState();
}

class _ModernHomeScreenState extends State<ModernHomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late TabController _tabController;

  final List<Widget> _pages = const [
    ModernLostItemsScreen(),
    ModernFoundItemsScreen(),
    ModernAddItemScreen(),
    ModernProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) {
              setState(() => _currentIndex = index);
            },
            height: 70,
            backgroundColor: Theme.of(context).cardColor,
            indicatorColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.2),
            animationDuration: const Duration(milliseconds: 400),
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.search_outlined),
                selectedIcon: Icon(
                  Icons.search_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                label: 'Lost',
              ),
              NavigationDestination(
                icon: const Icon(Icons.check_circle_outline_rounded),
                selectedIcon: Icon(
                  Icons.check_circle_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                label: 'Found',
              ),
              NavigationDestination(
                icon: const Icon(Icons.add_box_outlined),
                selectedIcon: Icon(
                  Icons.add_box_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                label: 'Add',
              ),
              NavigationDestination(
                icon: const Icon(Icons.person_outline_rounded),
                selectedIcon: Icon(
                  Icons.person_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ).animate().slideY(
            begin: 1,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
          ),
    );
  }
}
