import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String body;
  final String time;

  const NotificationItem({
    Key? key,
    required this.title,
    required this.body,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.notifications),
      title: Text(title),
      subtitle: Text(body),
      trailing: Text(time),
    );
  }
}
