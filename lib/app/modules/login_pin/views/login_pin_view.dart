import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qrm_dev/app/modules/login_pin/controllers/login_pin_controller.dart';

class LoginPinView extends StatelessWidget {
  final LoginPinController controller = Get.put(LoginPinController());

  LoginPinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.width * 0.1),

          // Judul
          Text(
            "MASUKKAN PIN",
            style: GoogleFonts.kanit().copyWith(
              fontSize: MediaQuery.of(context).size.width * 0.078,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.width * 0.05),

          // PIN Input dengan Stack
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.02),
                    child: Column(
                      children: [
                        // Angka PIN
                        Text(
                          controller.pin.value.length > index
                              ? controller.pin.value[index]
                              : "",
                          style: GoogleFonts.kanit().copyWith(
                            fontSize: 28,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 5), // Jarak antara angka dan indikator

                        // Indikator PIN
                        Container(
                          width: MediaQuery.of(context).size.width * 0.09,
                          height: MediaQuery.of(context).size.height * 0.004,
                          decoration: BoxDecoration(
                            color: controller.pin.value.length > index
                                ? Colors.black
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              )),

          SizedBox(height: MediaQuery.of(context).size.height * 0.03),

          // Keypad
          buildKeypad(context),

          SizedBox(height: MediaQuery.of(context).size.height * 0.09),
          Column(
            children: [
              Text(
                "QINAR RAYA MANDIRI",
                textAlign: TextAlign.center,
                style: GoogleFonts.kanit().copyWith(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.055,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Mobile Version'),
            ],
          ),
        ],
      ),
    );
  }

  /// Membuat Keypad angka
  Widget buildKeypad(BuildContext context) {
    List<String> keys = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "",
      "0",
      "⌫"
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.14),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: keys.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          String key = keys[index];
          return key.isEmpty
              ? SizedBox()
              : GestureDetector(
                  onTap: () {
                    if (key == "⌫") {
                      controller.deleteDigit();
                    } else {
                      controller.addDigit(key);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: key == "⌫" ? Colors.transparent : Colors.yellow,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        key,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.09,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
