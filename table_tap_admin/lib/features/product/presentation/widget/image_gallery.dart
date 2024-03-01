import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageGallery extends StatelessWidget {
  final String imageUrl;

  const ImageGallery({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => const SizedBox(
          width: 10,
          height: 10,
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
