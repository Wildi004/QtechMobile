import 'package:flutter/material.dart';

class SearchQuery {
  static Widget searchInput({
    ValueChanged<String>? onSubmitted,
    ValueChanged<String>? onChanged,
    String hint = 'Cari...',
    TextEditingController? controller,
  }) {
    return TextField(
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(Icons.search),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
