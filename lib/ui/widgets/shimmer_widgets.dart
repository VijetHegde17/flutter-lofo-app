import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Shimmer effect for loading states
class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerWidget({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

/// Shimmer skeleton for item card in feed
class ItemCardSkeleton extends StatelessWidget {
  const ItemCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image skeleton
          const ShimmerWidget(
            width: double.infinity,
            height: 200,
            borderRadius: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title skeleton
                const ShimmerWidget(width: double.infinity, height: 20),
                const SizedBox(height: 8),
                // Subtitle skeleton
                ShimmerWidget(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 16,
                ),
                const SizedBox(height: 12),
                // Badge skeleton
                const Row(
                  children: [
                    ShimmerWidget(width: 60, height: 24, borderRadius: 12),
                    SizedBox(width: 8),
                    ShimmerWidget(width: 80, height: 24, borderRadius: 12),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Shimmer skeleton for grid view loading
class GridSkeletonLoader extends StatelessWidget {
  final int itemCount;

  const GridSkeletonLoader({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) => const ItemCardSkeleton(),
    );
  }
}

/// Shimmer for profile header
class ProfileHeaderSkeleton extends StatelessWidget {
  const ProfileHeaderSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Avatar skeleton
        const ShimmerWidget(width: 100, height: 100, borderRadius: 50),
        const SizedBox(height: 16),
        // Name skeleton
        ShimmerWidget(
          width: MediaQuery.of(context).size.width * 0.4,
          height: 24,
        ),
        const SizedBox(height: 8),
        // Email skeleton
        ShimmerWidget(
          width: MediaQuery.of(context).size.width * 0.6,
          height: 16,
        ),
      ],
    );
  }
}
