import 'package:flutter/material.dart';
import 'package:tezda_task/app/shared/presentation/widgets/tezda_task_icon.dart';
import 'package:tezda_task/core/navigation/navigator.dart';

class tezda_taskBackButton extends StatelessWidget {
  const tezda_taskBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return tezda_taskIcon(
      icon: Icons.arrow_back_rounded,
      onTap: () {
        pop(context);
      },
    );
  }
}
