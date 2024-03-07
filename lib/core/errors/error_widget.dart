import 'package:flutter/material.dart';
import 'package:products_app_demo/core/bloc_helper.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget(
      {super.key, required this.message, required this.retryFunc});

  final String message;
  final Function retryFunc;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_outlined,
            color: Colors.redAccent,
            size: MediaQuery.of(context).size.width / 3,
          ),
          Text('Error!', style: Theme.of(context).textTheme.headlineSmall),
          Text(message),
          const SizedBox(height: 16),
          ElevatedButton(
              onPressed: () => retryFunc(), child: const Text('Try again'))
        ],
      ),
    );
  }
}
