import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/settings/controllers/settings_controller.dart';
import 'package:qrm_dev/app/widgets/custom_main_color.dart';

class CardProfileSettingView extends StatelessWidget {
  final SettingsController controller = Get.find();

  CardProfileSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.27,
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
      decoration: CustomMainColor.main(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: Obx(() {
        final user = controller.user.value;
        return Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.08,
                ),
                child: LzImage(
                  user?.image ?? 'https://via.placeholder.com/150',
                  size: MediaQuery.of(context).size.width * 0.3,
                  radius: MediaQuery.of(context).size.width * 0.3 / 2,
                  previewable: true,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.name ?? '-',
                      style: GoogleFonts.poppins().copyWith(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${user?.role ?? '-'} - ${user?.building ?? ''}",
                      style: GoogleFonts.poppins().copyWith(
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
