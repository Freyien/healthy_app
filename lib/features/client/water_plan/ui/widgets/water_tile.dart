import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/extensions/datetime.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/features/client/water_plan/domain/entities/water_consumption_entity.dart';
import 'package:healthy_app/features/client/water_plan/ui/bloc/water_plan_bloc.dart';

class WaterTile extends StatefulWidget {
  const WaterTile({
    super.key,
    required this.waterConsumption,
  });

  final WaterConsumptionEntity waterConsumption;

  @override
  State<WaterTile> createState() => _WaterTileState();
}

class _WaterTileState extends State<WaterTile>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return _Tile(waterConsumption: widget.waterConsumption);
  }

  @override
  bool get wantKeepAlive => true;
}

class _Tile extends StatelessWidget {
  const _Tile({required this.waterConsumption});

  final WaterConsumptionEntity waterConsumption;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appColors.scaffold,
        border: Border(
          top: BorderSide(
            color: context.appColors.border!.withOpacity(.5),
          ),
        ),
      ),
      child: ListTile(
        dense: true,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/gota-de-agua.png',
              height: 25,
            ),
          ],
        ),
        title: Text(
          '${waterConsumption.quantity} ML',
          style: TextStyle(
            color: context.appColors.textContrast,
          ),
        ),
        subtitle: Text(
          waterConsumption.date.format('d MMMM y HH:mm'),
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            context
                .read<WaterPlanBloc>()
                .add(DeleteWaterConsumptionEvent(waterConsumption));
          },
          icon: Icon(Icons.close, color: Colors.red),
        ),
        contentPadding: EdgeInsets.zero,
        tileColor: context.appColors.scaffold,
      ),
    );
  }
}
