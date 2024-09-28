import 'package:flutter/material.dart';
import 'package:poc_flutter/app/theme.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({
    super.key,
    required this.items,
    this.selected,
    this.borderRadius = 50,
    this.bottomMargin = 16,
    this.errorText,
    required this.hintText,
    required this.onChanged,
    required this.title,
    this.validator,
    this.value,
    this.titleFontSize = 20,
    this.titleFontWeight = FontWeight.w700,
  });
  final List items;
  final String? selected;
  final Function(String?)? onChanged;
  final String title, hintText;
  final String? Function(String?)? validator;
  final String? errorText;
  final double borderRadius;
  final double bottomMargin;
  final int? value;
  final double? titleFontSize;
  final FontWeight? titleFontWeight;

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    const bool isDarkMode = false;
    return Container(
      padding: EdgeInsets.only(bottom: widget.bottomMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (widget.title.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text(
                widget.title,
                style: theme.textTheme.headlineSmall!.copyWith(
                  fontWeight: widget.titleFontWeight,
                  fontSize: widget.titleFontSize,
                  letterSpacing: 0.28,
                  height: 1.3,
                ),
              ),
            ),
          DropdownButtonFormField<String>(
            items: widget.items.map<DropdownMenuItem<String>>((dynamic item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                ),
              );
            }).toList(),
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            onChanged: widget.onChanged,
            isExpanded: true,
            value: widget.selected,
            validator: widget.validator,
            dropdownColor: theme.scaffoldBackgroundColor,
            style: theme.textTheme.headlineSmall!.copyWith(
              // color: CustomTheme.primaryColor,
              letterSpacing: 0.2,
            ),
            decoration: InputDecoration(
              errorText: widget.errorText,
              counterText: '',
              errorStyle: theme.textTheme.bodyLarge!.copyWith(
                color: CustomTheme.errorColor,
                letterSpacing: 0.2,
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
              hintText: widget.hintText,
              hintStyle: theme.textTheme.headlineSmall!.copyWith(
                letterSpacing: 0.2,
                // color: CustomTheme.lightTextColor,
              ),
              fillColor: theme.scaffoldBackgroundColor,
              border: _border(isDarkMode),
              focusedBorder: _border(isDarkMode),
              enabledBorder: _border(isDarkMode),
              errorBorder: _border(isDarkMode, isErrorBorder: true),
              contentPadding: const EdgeInsets.only(
                  left: 16, bottom: 8, top: 16, right: 16),
            ),
          )
        ],
      ),
    );
  }

  OutlineInputBorder _border(bool isDarkMode, {bool isErrorBorder = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: BorderSide(
        color: isErrorBorder
            ? CustomTheme.errorColor
            : isDarkMode
                ? Colors.white
                : CustomTheme.lightGray.withOpacity(0.2),
      ),
    );
  }
}
