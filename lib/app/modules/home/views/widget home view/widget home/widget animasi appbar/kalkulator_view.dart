import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrm_dev/app/modules/home/controllers/kalkulator_controller.dart';

class KalkulatorDialog extends StatelessWidget {
  const KalkulatorDialog({super.key});
  @override
  Widget build(BuildContext context) {
    final c = Get.put(KalkulatorController());
    return Material(
      type: MaterialType.transparency,
      child: Obx(() {
        return Stack(
          children: [
            Positioned(
              left: c.position.value.dx,
              top: c.position.value.dy,
              child: GestureDetector(
                onPanUpdate: c.updatePosition,
                child: _dialogBody(c),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _dialogBody(KalkulatorController c) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 250,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.10),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(() => c.preview.value.isEmpty
                      ? const SizedBox()
                      : Text(
                          c.preview.value,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        )),
                  const SizedBox(height: 4),
                  Obx(() => Text(
                        c.displayRp,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 8),
              Column(
                children: [
                  _row(['7', '8', '9'], c),
                  const SizedBox(height: 8),
                  _row(['4', '5', '6'], c),
                  const SizedBox(height: 8),
                  _row(['1', '2', '3'], c),
                  const SizedBox(height: 8),
                  _row(['0', '+', '-'], c),
                  const SizedBox(height: 8),
                  _row(['/', 'x', '='], c),
                  const SizedBox(height: 8),
                  _rowAction(c),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _btn(String text, VoidCallback onTap, {Color? color}) {
    return SizedBox(
      width: 70,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.white.withOpacity(0.25),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _row(List<String> items, KalkulatorController c) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items.map((e) {
        if (e == '+' || e == '-' || e == 'x' || e == '/') {
          return _btn(e, () => c.operator(e));
        }
        if (e == '=') {
          return _btn(e, c.hitung, color: Colors.green);
        }
        return _btn(e, () => c.input(e));
      }).toList(),
    );
  }

  Widget _rowAction(KalkulatorController c) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _btn('C', c.clear, color: Colors.redAccent),
        _btn('⌫', c.remove, color: Colors.orange),
      ],
    );
  }
}
