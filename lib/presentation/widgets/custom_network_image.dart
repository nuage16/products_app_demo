import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget{
  const CustomNetworkImage({super.key, required this.imgUrl});

  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        imgUrl,
        fit: BoxFit.fitHeight,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          }
        },
        errorBuilder: (context, error, stackTrace) {
          return const Center(child: Text('Error!'));
        },
      ),
    );
  }

}