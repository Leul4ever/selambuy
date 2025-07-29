import 'package:flutter/material.dart';
import '../widgets/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  static bool isLoggedIn = false; // Simulate auth state for demo

  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isLoggedIn) {
      // If not logged in, redirect to SignInScreen
      Future.microtask(
          () => Navigator.of(context).pushReplacementNamed('/sign-in'));
      return const SizedBox.shrink();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: _dummyNotifications.length,
        itemBuilder: (context, index) {
          final notification = _dummyNotifications[index];
          return NotificationItem(
            title: notification['title']!,
            body: notification['body']!,
            time: notification['time']!,
          );
        },
      ),
    );
  }
}

final List<Map<String, String>> _dummyNotifications = [
  {
    'title': 'Order Shipped',
    'body': 'Your order #1234 has been shipped.',
    'time': '2h ago',
  },
  {
    'title': 'New Offer',
    'body': '50% Off on all items today!',
    'time': '5h ago',
  },
  {
    'title': 'Welcome!',
    'body': 'Thanks for joining EcoBazaar!',
    'time': '1d ago',
  },
];
