import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    // String imageURL = Faker.image(Fit.random, 5);
    // String imageGIF =
    //     'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/893964104784767.5f6aa6e12f6cf.gif';

    // final images = Faker.list.image(6, Fit.random);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image'),
      ),
      body: LzListView(
          // padding: Ei.zero,
          // // physics: Scrolics.page,
          // children: [
          //   Container(
          //     padding: Ei.all(20),
          //     child: const ExampleLabel(
          //       description:
          //           'LzImage is a flexible and powerful widget for displaying images from multiple sources and formats. It supports formats like JPG, JPEG, PNG, GIF, SVG, and accepts inputs such as image URLs, file paths, local asset paths, File objects, Uint8List, or pre-built Image widgets, providing seamless integration and consistent rendering across all use cases.',
          //     ),
          //   ),
          //   SingleChildScrollView(
          //     scrollDirection: Axis.horizontal,
          //     padding: Ei.sym(h: 20),
          //     physics: Scrolics.bounce,
          //     child: Row(
          //         spacing: 13,
          //         children: ['Url', 'Gif', 'Svg', 'Path'].generate((item, i) {
          //           double size = (context.width / 4) - 20;

          //           final images = [
          //             LzImage(imageURL, size: size),
          //             LzImage(imageGIF, size: size),
          //             LzImage('ic_launcher.png', size: size),
          //             LzImage('ic_launcher.png', size: size),
          //           ];

          //           return Column(
          //             spacing: 10,
          //             children: [images[i], Text(item, style: Gfont.fs14)],
          //           );
          //         })),
          //   ),
          //   35.height,
          //   Container(
          //       padding: Ei.all(20),
          //       child: Column(
          //         spacing: 25,
          //         children: [
          //           Textml(
          //               'Set <b>previewable: true</b> to allow opening the image in a new page with zoom-in and zoom-out support.'),
          //           ImageList(
          //             images: images,
          //           ),
          //         ],
          //       )),
          // ],
          ),
    );
  }
}

class ImageList extends StatelessWidget {
  final List<String> images;
  const ImageList({super.key, this.images = const []});

  @override
  Widget build(BuildContext context) {
    final images = _chunk(this.images, 3);

    return Column(
      spacing: 3,
      children: images.generate((col, i) {
        return Row(
          spacing: 3,
          children: col.generate((image, j) {
            return Expanded(
                flex: (i + j) == 2 ? 2 : 1,
                child: LzImage(image,
                    size: [context.width, 100], previewable: true));
          }),
        );
      }),
    );
  }
}

List<List<T>> _chunk<T>(List<T> array, int chunkSize) {
  if (chunkSize <= 0) {
    throw ArgumentError('Chunk size must be greater than 0');
  }

  List<List<T>> chunks = [];
  for (int i = 0; i < array.length; i += chunkSize) {
    chunks.add(array.sublist(
        i, i + chunkSize > array.length ? array.length : i + chunkSize));
  }
  return chunks;
}

class ExampleLabel extends StatelessWidget {
  final String? description;
  const ExampleLabel({super.key, this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          description ?? '',
          style: Gfont.muted.theme(context, '777'.hex),
        ),
        const SizedBox(height: 30),
        Textr('Overview',
            style: Gfont.green,
            icon: Hi.file01,
            border: Br.only(['b']),
            width: context.width,
            padding: Ei.sym(v: 10)),
        const SizedBox(height: 25),
      ],
    ).start;
  }
}
