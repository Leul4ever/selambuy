import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/promotional/promotional_bloc.dart';

class PromotionalSectionWidget extends StatelessWidget {
  const PromotionalSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromotionalBloc, PromotionalState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // New Arrivals Section
            if (state.newArrivals.isNotEmpty) ...[
              _buildSectionHeader(context, 'New Arrivals', Icons.new_releases),
              const SizedBox(height: 16),
              _buildHorizontalScrollList(context, state.newArrivals),
              const SizedBox(height: 32),
            ],
            // Seasonal Offers Section
            if (state.seasonalOffers.isNotEmpty) ...[
              _buildSectionHeader(context, 'Seasonal Offers', Icons.local_offer),
              const SizedBox(height: 16),
              _buildHorizontalScrollList(context, state.seasonalOffers),
              const SizedBox(height: 32),
            ],
            // Discount Deals Section
            if (state.discountDeals.isNotEmpty) ...[
              _buildSectionHeader(context, 'Discount Deals', Icons.discount),
              const SizedBox(height: 16),
              _buildHorizontalScrollList(context, state.discountDeals),
              const SizedBox(height: 32),
            ],
          ],
        );
      },
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 24,
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            // TODO: Navigate to section page
          },
          child: Text(
            'View All',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalScrollList(BuildContext context, List<PromotionalItem> items) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            width: 200,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: _PromotionalItemCard(item: item),
          );
        },
      ),
    );
  }
}

class _PromotionalItemCard extends StatelessWidget {
  final PromotionalItem item;

  const _PromotionalItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  item.imageUrl,
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: double.infinity,
                    height: 160,
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: Icon(
                      Icons.image,
                      size: 48,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
              // Badge
              if (item.badgeText != null)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getBadgeColor(item.badgeColor ?? 'primary'),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      item.badgeText!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              // Discount Percentage
              if (item.discountPercentage != null)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.error,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '-${item.discountPercentage!.toInt()}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // Price Section
                if (item.originalPrice != null || item.discountedPrice != null)
                  Row(
                    children: [
                      if (item.discountedPrice != null) ...[
                        Text(
                          '\$${item.discountedPrice!.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (item.originalPrice != null) ...[
                          const SizedBox(width: 8),
                          Text(
                            '\$${item.originalPrice!.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ] else if (item.originalPrice != null) ...[
                        Text(
                          '\$${item.originalPrice!.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getBadgeColor(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'primary':
        return Colors.blue;
      case 'secondary':
        return Colors.green;
      case 'accent':
        return Colors.orange;
      case 'error':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}
