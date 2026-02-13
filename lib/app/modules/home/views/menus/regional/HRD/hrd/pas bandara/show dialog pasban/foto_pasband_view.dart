import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

Widget buildFoto(String? url, String token) {
  return url != null && url.isNotEmpty
      ? LzImage(
          url,
          previewable: true,
          fit: BoxFit.contain,
          size: 100,
          headers: {'Authorization': 'Bearer $token'},
        )
      : Center(
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Center(
              child: Text(
                'Foto tidak ditambahkan',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
}
