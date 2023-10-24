import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/widgets/horizontal_space.dart';

class EatingTile extends StatelessWidget {
  const EatingTile({
    super.key,
    required this.calories,
    required this.name,
    required this.pathImage,
    required this.portion,
  });

  final String calories;
  final String name;
  final String pathImage;
  final String portion;

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColors;

    return Slidable(
      key: key,
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: .5,
        openThreshold: .1,
        dragDismissible: true,
        children: [
          SlidableAction(
            onPressed: (_) {},
            backgroundColor: appColor.primary!,
            foregroundColor: Colors.white,
            icon: Icons.sync,
            label: 'Cambiar',
          ),
        ],
      ),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: appColor.border!.withOpacity(.2),
              ),
            ),
          ),
          child: Row(
            children: [
              // Image
              Image.asset(
                pathImage,
                width: 25,
                height: 25,
              ),
              HorizontalSpace.xxlarge(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Portion
                    Text(
                      portion,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              // Calories
              Text(
                calories,
                style: TextStyle(color: Colors.grey),
              ),
              CupertinoCheckbox(
                value: true,
                onChanged: (_) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
