import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/services/storage/storage.dart';

class TokenImage extends StatefulWidget {
  final String url;
  const TokenImage(this.url, {super.key});

  @override
  State<TokenImage> createState() => _TokenImageState();
}

class _TokenImageState extends State<TokenImage> {
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  Future<void> loadImage() async {
    String? token = storage.read('token');
    Map<String, String>? headers = {
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(
      Uri.parse(widget.url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      setState(() {
        imageBytes = response.bodyBytes;
      });
    } else {
      logg('Gagal ambil gambar: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return imageBytes != null
        ? Image.memory(
            imageBytes!,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          )
        : const CircularProgressIndicator();
  }
}
