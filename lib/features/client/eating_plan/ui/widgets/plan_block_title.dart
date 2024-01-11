import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/client/eating_plan/domain/entities/plan_block_entity.dart';

class PlanBlockTitle extends StatelessWidget {
  const PlanBlockTitle({super.key, required this.planBlock});

  final PlanBlockEntity planBlock;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        planBlock.type.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: context.appColors.textContrast,
        ),
      ),
      trailing: Stack(
        children: [
          IconButton(
            icon: Icon(Icons.message_outlined),
            disabledColor: context.appColors.textContrast!.withOpacity(.3),
            onPressed: planBlock.comment.isNotEmpty //
                ? () => _showComment(context)
                : null,
          ),

          // Comment
          if (planBlock.comment.isNotEmpty)
            Positioned(
              right: 5,
              top: 0,
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.appColors.primary,
                ),
                child: Text(
                  '1',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
      contentPadding: EdgeInsets.zero,
    );
  }

  void _showComment(BuildContext context) {
    showAdaptiveDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (BuildContext dialogContext) {
        return AlertDialog.adaptive(
          backgroundColor: context.appColors.scaffold,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          title: Text(planBlock.type.title),
          content: Text(
            planBlock.comment,
            textAlign: TextAlign.start,
          ),
          actions: <Widget>[
            AdaptiveAction(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
