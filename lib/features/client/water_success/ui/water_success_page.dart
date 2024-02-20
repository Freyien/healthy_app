import 'dart:typed_data';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_app/core/extensions/datetime.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/utils/loading.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class WaterSuccessPage extends StatefulWidget {
  const WaterSuccessPage({
    super.key,
    required this.imageName,
    required this.message,
    required this.subtitle,
    required this.date,
  });

  final String imageName;
  final String message;
  final String subtitle;
  final DateTime date;

  @override
  State<WaterSuccessPage> createState() => _WaterSuccessPageState();
}

class _WaterSuccessPageState extends State<WaterSuccessPage> {
  late ScreenshotController controller;
  late Uint8List? image;

  @override
  void initState() {
    super.initState();
    image = null;
    controller = ScreenshotController();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final size = width * .5;
    final appColors = context.appColors;

    return Scaffold(
      appBar: AppBar(
        title: Text('¡Felicidades!'),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.share),
          //   onPressed: _share,
          // ),

          CupertinoButton(
            child: Text('Compartir'),
            onPressed: _share,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Screenshot(
                controller: controller,
                child: ColoredBox(
                  color: context.appColors.scaffold!,
                  child: Stack(
                    children: [
                      // _Confetti
                      ConfettiBackground(
                        showConfetti: true,
                        delay: Duration(milliseconds: 1600),
                        opacity: .4,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: double.infinity),

                            // Image
                            FadeInDown(
                              from: 10,
                              child: SvgPicture.asset(
                                'assets/svg/trophies/${widget.imageName}.svg',
                                width: size,
                              ),
                            ),
                            VerticalSpace.medium(),

                            // Title
                            FadeInUp(
                              delay: Duration(milliseconds: 400),
                              from: 10,
                              child: Text(
                                widget.message,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: appColors.textContrast,
                                  letterSpacing: -.5,
                                ),
                              ),
                            ),

                            // Date
                            FadeInUp(
                              delay: Duration(milliseconds: 800),
                              from: 10,
                              child: Text(
                                widget.date.format('dd MMMM yyyy'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                      appColors.textContrast!.withOpacity(.8),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            VerticalSpace.small(),

                            // Subtitle
                            FadeInUp(
                              delay: Duration(milliseconds: 1200),
                              from: 20,
                              child: Text(
                                widget.subtitle,
                                style: TextStyle(
                                  fontSize: 35,
                                  color:
                                      appColors.textContrast!.withOpacity(.7),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _share() async {
    LoadingUtils.show(context);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    String fileName = DateTime.now().microsecondsSinceEpoch.toString() + '.png';

    final filePath = await controller.captureAndSave(
      path,
      fileName: fileName,
    );

    LoadingUtils.hide(context);

    await Share.shareXFiles(
      [
        XFile(filePath!),
      ],
    );
  }
}
