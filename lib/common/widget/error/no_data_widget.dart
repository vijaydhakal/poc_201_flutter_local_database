import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:poc_flutter/common/constant/constant_assets.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key, this.message});
  final String? message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Assets.logo,
            height: 200,
            width: 200,
          ),
          const Gap(16),
          Text(
            message ?? "No data found",
            style: theme.textTheme.titleLarge,
          )
        ],
      ),
    );
  }
}
