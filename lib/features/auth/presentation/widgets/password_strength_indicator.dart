import 'package:flutter/material.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final String password;
  const PasswordStrengthIndicator({Key? key, required this.password})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _PasswordStrength strength = _evaluatePassword(password);
    final color = strength.color;
    final label = strength.label;
    final value = strength.value;
    final tips = strength.tips;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: value,
                minHeight: 8,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(color),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        if (tips.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              tips,
              style: TextStyle(color: color.withOpacity(0.8), fontSize: 13),
            ),
          ),
      ],
    );
  }
}

class _PasswordStrength {
  final double value;
  final Color color;
  final String label;
  final String tips;
  const _PasswordStrength(
      {required this.value,
      required this.color,
      required this.label,
      required this.tips});
}

_PasswordStrength _evaluatePassword(String password) {
  if (password.isEmpty) {
    return const _PasswordStrength(
      value: 0.0,
      color: Colors.grey,
      label: '',
      tips: '',
    );
  }
  final hasLetters = RegExp(r'[A-Za-z]').hasMatch(password);
  final hasNumbers = RegExp(r'[0-9]').hasMatch(password);
  final hasSymbols = RegExp(r'[^A-Za-z0-9]').hasMatch(password);
  if (password.length < 6) {
    return const _PasswordStrength(
      value: 0.33,
      color: Colors.red,
      label: 'Weak',
      tips: 'Use at least 8 characters',
    );
  } else if (password.length <= 10 && hasLetters && hasNumbers) {
    return const _PasswordStrength(
      value: 0.66,
      color: Colors.orange,
      label: 'Medium',
      tips: 'Add special characters like @ or #',
    );
  } else if (password.length > 10 && hasLetters && hasNumbers && hasSymbols) {
    return const _PasswordStrength(
      value: 1.0,
      color: Colors.green,
      label: 'Strong',
      tips: '',
    );
  } else if (password.length > 10) {
    return const _PasswordStrength(
      value: 0.8,
      color: Colors.orange,
      label: 'Medium',
      tips: 'Combine letters, numbers, and symbols',
    );
  } else {
    return const _PasswordStrength(
      value: 0.33,
      color: Colors.red,
      label: 'Weak',
      tips: 'Combine letters and numbers',
    );
  }
}
