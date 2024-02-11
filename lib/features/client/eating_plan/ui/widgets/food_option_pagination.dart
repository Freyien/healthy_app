import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/features/client/eating_plan/domain/entities/food_block_entity.dart';
import 'package:healthy_app/features/client/eating_plan/ui/bloc/eating_plan_bloc.dart';
import 'package:healthy_app/features/client/eating_plan/ui/widgets/eating_tile.dart';

class FoodOptionPagination extends StatefulWidget {
  const FoodOptionPagination({super.key, required this.foodBlock});

  final FoodBlockEntity foodBlock;

  @override
  State<FoodOptionPagination> createState() => _FoodOptionPaginationState();
}

class _FoodOptionPaginationState extends State<FoodOptionPagination>
    with AutomaticKeepAliveClientMixin {
  late bool checked;

  @override
  void initState() {
    super.initState();
    checked = widget.foodBlock.checked;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ExpandablePageView.builder(
      estimatedPageSize: 65,
      physics: ClampingScrollPhysics(),
      itemCount: widget.foodBlock.optionList.length,
      itemBuilder: (context, index) {
        final foodOption = widget.foodBlock.optionList[index];

        return EatingTile(
          foodOption: foodOption,
          checked: checked,
          dotsLength: widget.foodBlock.optionList.length,
          activeDotIndex: index,
          onChanged: (value) {
            setState(() => checked = value!);
            context
                .read<EatingPlanBloc>()
                .add(CheckFoodEvent(widget.foodBlock, value!));
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
