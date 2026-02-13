import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/surat%20eksternal/surat_eksternal.dart';
import 'package:qrm_dev/app/modules/home/controllers/Surat%20Eksternal/surat_eksternal_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/surat%20eksternal/create_get_surat_eksternal_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class SuratEksternalView extends GetView<SuratEksternalController> {
  const SuratEksternalView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SuratEksternalController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Surat Eksternal',
        actions: [
          IconButton(
            onPressed: () async {
              Get.to(() => CreateGetSuratEksternalView())?.then((data) {
                if (data != null) {
                  controller.insertData(SuratEksternal.fromJson(data));
                }
              });
            },
            icon: Icon(Hi.add01),
            color: Colors.white,
          ),
        ],
      ).appBar,
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        bool isLoading = controller.isLoading.value;
        final data = controller.listSurat;

        if (isLoading) {
          return const Center(child: CustomLoading());
        }

        if (data.isEmpty) {
          return Empty(
            message: 'tidak ada data.',
            onTap: () => controller.getData(),
          );
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: SearchQuery.searchInput(
                      onSubmitted: controller.updateSearchQuery,
                      controller: controller.searchC,
                      hint: 'Search...',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: LzListView(
                padding: Ei.sym(v: 10, h: 20),
                onRefresh: () => controller.getData(),
                onScroll: (scroll) {
                  if (scroll.atBottom(100)) {
                    controller.onPaginate();
                  }
                },
                children: [
                  ...data.generate((item, i) {
                    return CustomScalaContainer(
                      child: Touch(
                        onTap: () {},
                        margin: Ei.only(b: 10),
                        child: Container(
                          width: itemWidth,
                          padding: const EdgeInsets.all(10),
                          decoration: CustomDecoration.validator(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetailText('No Surat: ', item.noSurat),
                              _buildDetailText('Keperluan: ', item.keperluan),
                              _buildDetailText('Tanggal: ', item.tgl),
                              _buildDetailText(
                                  'Digunakan Oleh: ', item.userName),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  Obx(
                    () => CustomLoading().lz.hide(!controller.isPaginate.value),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  /// Widget helper untuk membuat teks dengan judul bold dan isi wrap
  Widget _buildDetailText(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            '$title: ',
            style: GoogleFonts.poppins().copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            value ?? '-',
            style: GoogleFonts.poppins().copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
