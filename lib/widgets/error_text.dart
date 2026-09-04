import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String error;
  final double? paddingLeft;
  const ErrorText({super.key, required this.error, this.paddingLeft});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: paddingLeft ?? 0),
      child: Text(
        error,
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
    );
  }
}
