import 'package:flutter/material.dart';

class ButtonWithLeadingIcon extends StatelessWidget {
  const ButtonWithLeadingIcon(
      {super.key, @required this.name,
      this.function,
      this.backgroundColor,
      required this.icon,
      required this.iconColor,
      this.leading,
      this.textColor,
      this.borderColor,
      this.width});
  final String? name;
  final IconData icon;
  final Function? function;
  final Color? backgroundColor;
  final Color? iconColor;
  final Widget? leading;
  final double? width;

  final Color? textColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: function == null ? null : () => function!(),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            width: (width) / 1.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                  color: borderColor ?? const Color(0xFF707070).withOpacity(0.2)),
              color: backgroundColor,
            ),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    name!,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: textColor ?? Colors.black,
                        ),
                  ),
                ),
                Positioned(
                  left: 4,
                  child: leading ??
                      Icon(
                        icon,
                        color: iconColor,
                        size: 22,
                      ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
