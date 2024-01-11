import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/features/client/eating_plan/domain/entities/food_block_entity.dart';
import 'package:healthy_app/features/client/eating_plan/ui/bloc/eating_plan_bloc.dart';
import 'package:healthy_app/features/client/eating_plan/ui/widgets/eating_tile.dart';

class FoodOptionPagination extends StatelessWidget {
  const FoodOptionPagination({super.key, required this.foodBlock});

  final FoodBlockEntity foodBlock;

  @override
  Widget build(BuildContext context) {
    bool checked = foodBlock.checked;

    return StatefulBuilder(
      builder: (context, setState) {
        return ExpandablePageView.builder(
          estimatedPageSize: 65,
          physics: ClampingScrollPhysics(),
          itemCount: foodBlock.optionList.length,
          itemBuilder: (context, index) {
            final foodOption = foodBlock.optionList[index];

            return EatingTile(
              foodOption: foodOption,
              checked: checked,
              dotsLength: foodBlock.optionList.length,
              activeDotIndex: index,
              onChanged: (value) {
                setState(() => checked = value!);
                context
                    .read<EatingPlanBloc>()
                    .add(CheckFoodEvent(foodBlock, value!));
              },
            );
          },
        );
      },
    );
  }
}
