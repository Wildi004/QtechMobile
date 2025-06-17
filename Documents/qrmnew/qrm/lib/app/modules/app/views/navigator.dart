import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';

import '../controllers/app_controller.dart';

class NavbarWidget extends GetView<AppController> {
  final Function(int index)? onTap;
  const NavbarWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final labels = ['Home', 'Absen', 'Surat Masuk', 'Settings'];

    return Obx(() {
      int navIndex = controller.navIndex.value;

      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.width * 0.02,
          left: MediaQuery.of(context).size.width * 0.06,
          right: MediaQuery.of(context).size.width * 0.06,
          top: MediaQuery.of(context).size.width * 0.003,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width * 0.01,
            horizontal: MediaQuery.of(context).size.width * 0.02,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: ['4CA1AF'.hex, '808080'.hex],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: const Color.fromARGB(66, 118, 13, 13)),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(31, 125, 6, 6),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [Hi.home01, Hi.time02, Hi.mailAdd01, Hi.settings02]
                    .generate((item, i) {
                  Color color = navIndex == i
                      ? const Color.fromARGB(221, 255, 255, 255)
                      : const Color.fromARGB(255, 0, 0, 0);

                  return InkWell(
                    onTap: () => onTap?.call(i),
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.width * 0.005,
                        horizontal: MediaQuery.of(context).size.width * 0.02,
                      ),
                      child: Column(
                        children: [
                          Icon(
                            item,
                            color: color,
                            size: MediaQuery.of(context).size.width * 0.066,
                          ),
                          Text(
                            labels[i],
                            style: Gfont.fs12.fcolor(color).copyWith(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 3,
                            width: 24,
                            decoration: BoxDecoration(
                              color: navIndex == i
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      );
    });
  }
}
