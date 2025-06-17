import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImageView extends StatelessWidget {
  final Uint8List? imageBytes;
  final String? imageUrl;

  const FullScreenImageView({super.key, this.imageBytes, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    ImageProvider? provider;

    if (imageBytes != null) {
      provider = MemoryImage(imageBytes!);
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      provider = NetworkImage(imageUrl!);
    }

    if (provider == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: BackButton(color: Colors.white),
          title: Text('No Image', style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: Colors.transparent,
        body: Center(
            child: Text('Gambar tidak tersedia',
                style: TextStyle(color: Colors.white))),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: BackButton(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Hero(
          tag: 'imageHero',
          child: PhotoView(
            imageProvider: provider,
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          ),
        ),
      ),
    );
  }
}
