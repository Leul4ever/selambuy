import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/profile_local_datasource.dart';
import '../../data/models/order_status_model.dart';

class OrderStatusGridWidget extends StatelessWidget {
  const OrderStatusGridWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Orders',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2E7D32),
                ),
          ),
          const SizedBox(height: 8),
          FutureBuilder<List<OrderStatusModel>>(
            future: ProfileLocalDataSourceImpl().getOrderStatuses(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError || !snapshot.hasData) {
                return const Center(
                    child: Text('Failed to load order statuses'));
              }

              final orderStatuses = snapshot.data!;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.2,
                ),
                itemCount: orderStatuses.length,
                itemBuilder: (context, index) {
                  final status = orderStatuses[index];
                  return _buildOrderStatusItem(context, status);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOrderStatusItem(BuildContext context, OrderStatusModel status) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: status.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getIconForStatus(status.id),
              color: status.color,
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            status.title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2E7D32),
                ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (status.count > 0) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: status.color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${status.count}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  IconData _getIconForStatus(String statusId) {
    switch (statusId) {
      case 'pending_payment':
        return Icons.account_balance_wallet;
      case 'delivered':
        return Icons.local_shipping;
      case 'processing':
        return Icons.shopping_cart_checkout;
      case 'cancelled':
        return Icons.cancel;
      case 'wishlist':
        return Icons.favorite;
      case 'customer_care':
        return Icons.headset_mic;
      default:
        return Icons.info;
    }
  }
}
