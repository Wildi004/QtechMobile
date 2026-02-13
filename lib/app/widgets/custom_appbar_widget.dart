import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:qrm_dev/app/widgets/color_hex.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;
  final String title;

  const CustomAppbar({
    super.key,
    this.actions = const [],
    required this.title,
  });

  static const Color backgroundColor = Color(0xFFAC7823);
  static const TextStyle titleStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static BoxDecoration get gradientBackground => BoxDecoration(
        gradient: LinearGradient(
          colors: ['#5B2A2A'.hex, '#8B4A4A'.hex],
          begin: Alignment.topCenter,
          end: Alignment.topRight,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: actions,
      title: LayoutBuilder(
        builder: (context, constraints) {
          final textPainter = TextPainter(
            text: TextSpan(text: title, style: titleStyle),
            maxLines: 1,
            textDirection: TextDirection.ltr,
          )..layout(maxWidth: constraints.maxWidth * 0.8);

          if (textPainter.didExceedMaxLines) {
            return SizedBox(
              height: 20,
              child: Marquee(
                text: title,
                style: titleStyle,
                velocity: 40.0,
                blankSpace: 50.0,
                pauseAfterRound: const Duration(seconds: 1),
              ),
            );
          } else {
            return Text(title,
                style: titleStyle, overflow: TextOverflow.ellipsis);
          }
        },
      ),
      flexibleSpace: Container(decoration: gradientBackground),
    );
  }

  PreferredSizeWidget get appBar => this;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomAppbarRed extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;
  final String title;

  const CustomAppbarRed({
    super.key,
    this.actions = const [],
    required this.title,
  });

  static const Color backgroundColor = Colors.red;
  static const TextStyle titleStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static BoxDecoration get gradientBackground => BoxDecoration(
        gradient: LinearGradient(
          colors: ['#5B2A2A'.hex, '#5B2A2A'.hex],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: actions,
      title: LayoutBuilder(
        builder: (context, constraints) {
          final textPainter = TextPainter(
            text: TextSpan(text: title, style: titleStyle),
            maxLines: 1,
            textDirection: TextDirection.ltr,
          )..layout(maxWidth: constraints.maxWidth * 0.8);

          if (textPainter.didExceedMaxLines) {
            return SizedBox(
              height: 20,
              child: Marquee(
                text: title,
                style: titleStyle,
                velocity: 40.0,
                blankSpace: 50.0,
                pauseAfterRound: const Duration(seconds: 1),
              ),
            );
          } else {
            return Text(
              title,
              style: titleStyle,
              overflow: TextOverflow.ellipsis,
            );
          }
        },
      ),
      flexibleSpace: Container(decoration: gradientBackground),
    );
  }

  PreferredSizeWidget get appBar => this;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
