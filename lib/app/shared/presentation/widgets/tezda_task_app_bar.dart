import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda_task/app/shared/presentation/widgets/tezda_task_back_button.dart';
import 'package:tezda_task/core/framework/theme/colors/app_theme_provider.dart';

class tezda_taskAppBar extends ConsumerWidget {
  final String title;
  final List<Widget>? trailing;
  final bool hasBackButton;
  const tezda_taskAppBar({
    super.key,
    required this.title,
    this.trailing,
    this.hasBackButton = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.read(appThemeProvider).colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasBackButton) ...[
          const tezda_taskBackButton(),
          const SizedBox(height: 24),
        ],
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: colors.alwaysWhite,
                ),
              ),
            ),
            if (trailing != null) ...trailing!,
          ],
        ),
      ],
    );
  }
}
