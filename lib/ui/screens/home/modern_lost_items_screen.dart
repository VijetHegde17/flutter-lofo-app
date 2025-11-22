import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../providers/item_provider.dart';
import '../../widgets/modern_item_card.dart';
import '../../widgets/shimmer_widgets.dart';
import '../item_details/modern_item_details_screen.dart';

/// Modern Lost Items screen with Pinterest-style masonry grid
class ModernLostItemsScreen extends ConsumerWidget {
  const ModernLostItemsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(lostItemsProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Modern App Bar
          SliverAppBar.large(
            floating: true,
            pinned: true,
            expandedHeight: 120,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/app_logo.png',
                height: 32,
                width: 32,
                fit: BoxFit.contain,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Lost Items',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
              expandedTitleScale: 1.3,
            ),
          ),

          // Items Grid
          itemsAsync.when(
            data: (items) {
              if (items.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 80,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No lost items yet',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.6),
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Items marked as lost will appear here',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.4),
                              ),
                        ),
                      ],
                    ).animate().fadeIn().scale(),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverMasonryGrid.count(
                  crossAxisCount: _getCrossAxisCount(context),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ModernItemCard(
                      item: item,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ModernItemDetailsScreen(item: item),
                          ),
                        );
                      },
                    )
                        .animate()
                        .fadeIn(
                          delay: Duration(milliseconds: index * 50),
                          duration: const Duration(milliseconds: 400),
                        )
                        .slideY(
                          begin: 0.2,
                          delay: Duration(milliseconds: index * 50),
                        );
                  },
                ),
              );
            },
            loading: () => SliverFillRemaining(
              child: GridSkeletonLoader(itemCount: 6),
            ),
            error: (error, _) => SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 64,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Something went wrong',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      error.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 4;
    if (width > 800) return 3;
    return 2;
  }
}
