import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/capaian_controller.dart';

class CapaianView extends GetView<CapaianControsller> {
  const CapaianView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CapaianView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CapaianView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
