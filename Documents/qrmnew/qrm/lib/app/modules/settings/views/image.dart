import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';
import 'package:photo_view/photo_view.dart';
import 'package:qrm/app/data/services/storage/auth.dart';

class FullScreenImageView extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: FutureBuilder(
          future: Auth.user(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Memuat...', style: TextStyle(color: Colors.white));
            }

            if (!snapshot.hasData || snapshot.hasError) {
              return Text('Gagal', style: TextStyle(color: Colors.white));
            }

            final user = snapshot.data;

            return Text(
              '${user?.name}',
              style: TextStyle(color: Colors.white, fontWeight: Fw.bold),
              overflow: TextOverflow.ellipsis,
            );
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Hero(
          tag: 'imageHero',
          child: PhotoView(
            imageProvider: NetworkImage(imageUrl),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          ),
        ),
      ),
    );
  }
}
