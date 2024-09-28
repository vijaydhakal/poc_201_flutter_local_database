import 'package:flutter/material.dart';
import 'package:poc_flutter/app/theme.dart';
import 'package:poc_flutter/common/util/size_utils.dart';
import 'package:poc_flutter/common/widget/shimmer/shimmer_container.dart';
import 'package:poc_flutter/common/widget/shimmer/shimmer_wrapper.dart';

class CommonListShimmer extends StatelessWidget {
  const CommonListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: Container(
        margin: EdgeInsets.only(
            bottom: 8,
            left: CustomTheme.symmetricHozPadding.hp,
            right: CustomTheme.symmetricHozPadding.hp),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 9,
          itemBuilder: (context, index) {
            return const Column(
              children: [
                ShimmerContainer(
                  height: 85,
                  width: null,
                ),
                ShimmerContainer(
                  height: 10,
                  width: null,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
