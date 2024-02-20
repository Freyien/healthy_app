import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:shimmer/shimmer.dart';

class TrophyButton extends StatelessWidget {
  const TrophyButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CircleIconButton(
      onPressed: onTap,
      icon: BounceInLeft(
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/svg/trophies/trophy-8.svg',
              width: 30,
              height: 30,
            ),
            Shimmer.fromColors(
              period: Duration(seconds: 2),
              baseColor: Colors.transparent,
              highlightColor: Colors.yellow.withOpacity(.6),
              child: SvgPicture.asset(
                'assets/svg/trophies/trophy-8.svg',
                width: 30,
                height: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
