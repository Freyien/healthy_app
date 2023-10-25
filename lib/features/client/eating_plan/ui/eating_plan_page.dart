import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/client/eating_plan/ui/widgets/eating_tile.dart';

class EatingPlanPage extends StatelessWidget {
  const EatingPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('24 Octubre 2023'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.calendar_month_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: ScrollFillRemaining(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Desayuno',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              VerticalSpace.xsmall(),
              const HorizontalDivider(),
              const EatingTile(
                calories: '75 kcal',
                name: 'Manzana',
                pathImage: 'assets/images/apple.png',
                portion: '1 pieza',
              ),
              const EatingTile(
                calories: '250 kcal',
                name: 'Pepino',
                pathImage: 'assets/images/cucumber.png',
                portion: '1/2 pieza',
              ),
              const EatingTile(
                calories: '50 kcal',
                name: 'Queso panela',
                pathImage: 'assets/images/cheese.png',
                portion: '40 grs',
              ),
              VerticalSpace.xxxlarge(),
              Text(
                'Almuerzo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              VerticalSpace.xsmall(),
              const HorizontalDivider(),
              const EatingTile(
                calories: '75 kcal',
                name: 'Jugo verde',
                pathImage: 'assets/images/green_juice.png',
                portion: '1 pieza',
              ),
              const EatingTile(
                calories: '250 kcal',
                name: 'Huevo',
                pathImage: 'assets/images/egg.png',
                portion: '1 pieza',
              ),
              const EatingTile(
                calories: '50 kcal',
                name: 'Queso panela',
                pathImage: 'assets/images/cheese.png',
                portion: '40 grs',
              ),
              VerticalSpace.xxxlarge(),
              Text(
                'Comida',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              VerticalSpace.xsmall(),
              const HorizontalDivider(),
              const EatingTile(
                calories: '75 kcal',
                name: 'Manzana',
                pathImage: 'assets/images/apple.png',
                portion: '1 pieza',
              ),
              const EatingTile(
                calories: '250 kcal',
                name: 'Pepino',
                pathImage: 'assets/images/cucumber.png',
                portion: '1/2 pieza',
              ),
              const EatingTile(
                calories: '50 kcal',
                name: 'Queso panela',
                pathImage: 'assets/images/cheese.png',
                portion: '40 grs',
              ),
              VerticalSpace.xxxlarge(),
              Text(
                'Almuerzo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
