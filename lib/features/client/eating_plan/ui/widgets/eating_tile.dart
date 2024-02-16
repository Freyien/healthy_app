import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/client/eating_plan/domain/entities/food_option_entity.dart';
import 'package:healthy_app/features/client/eating_plan/ui/widgets/food_portion.dart';

class EatingTile extends StatelessWidget {
  const EatingTile({
    super.key,
    required this.foodOption,
    required this.onChanged,
    required this.checked,
    required this.dotsLength,
    required this.activeDotIndex,
  });

  final FoodOptionEntity foodOption;
  final Function(bool?) onChanged;
  final bool checked;
  final int dotsLength;
  final int activeDotIndex;

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return CheckboxListTile.adaptive(
      value: checked,
      onChanged: onChanged,
      activeColor: appColors.primary,
      secondary: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (dotsLength == 1) VerticalSpace.xsmall(),

          // Image
          CachedNetworkImage(
            imageUrl: foodOption.imageUrl,
            width: 30,
            height: 30,
            placeholder: (context, url) {
              return Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: appColors.loadingBackground,
                  shape: BoxShape.circle,
                ),
              );
            },
          ),

          if (dotsLength > 1) VerticalSpace.xsmall(),

          // Dots
          if (dotsLength > 1)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                dotsLength,
                (dotIndex) {
                  final isActive = dotIndex == activeDotIndex;

                  return Container(
                    height: 6,
                    width: 6,
                    margin: EdgeInsets.only(right: 3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          isActive ? context.appColors.primary! : Colors.grey,
                    ),
                  );
                },
              ),
            ),
        ],
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name
          Flexible(
            child: Text(
              foodOption.name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: context.appColors.primary,
                fontSize: 14,
              ),
            ),
          ),

          HorizontalSpace.small(),

          // Portion
          if (foodOption.comment.isNotEmpty) FoodPortion(food: foodOption)
        ],
      ),
      subtitle: foodOption.comment.isNotEmpty
          ? Text(
              foodOption.comment,
              style: TextStyle(
                color: context.appColors.textContrast,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            )
          : FoodPortion(food: foodOption),
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      dense: true,
      controlAffinity: ListTileControlAffinity.trailing,
      shape: Border(
        bottom: BorderSide(
          color: appColors.border!.withOpacity(.04),
        ),
      ),
    );
  }
}
