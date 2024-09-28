import 'package:flutter/material.dart';
import 'package:poc_flutter/app/theme.dart';
import 'package:poc_flutter/common/util/size_utils.dart';

typedef validator = String? Function(String? value);

class InputFormTextfieldWithLabel extends StatefulWidget {
  const InputFormTextfieldWithLabel({
    required this.hintText,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.readonly = false,
    this.validationFunction,
    this.touchFunction,
    this.focusNode,
    this.maxlines = 1,
    this.suffixIcon,
    required this.labelText,
  });
  final String? hintText;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final bool? obscureText, readonly;
  final validator? validationFunction;
  final Function? touchFunction;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final String labelText;
  final int maxlines;
  @override
  _InputFormTextfieldState createState() => _InputFormTextfieldState();
}

class _InputFormTextfieldState extends State<InputFormTextfieldWithLabel> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _txt = _theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          textScaler: TextScaler.linear(SizeUtils.textScaleFactor),
          style: _txt.headlineSmall!.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.wp),
        Container(
          // height: 48.wp,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: CustomTheme.primaryColor.withOpacity(0.7),
              blurRadius: 4.5,
              spreadRadius: 4.5,
            )
          ]),
          child: TextFormField(
            maxLines: widget.maxlines,
            textAlignVertical: TextAlignVertical.center,
            focusNode: widget.focusNode,
            controller: widget.controller,
            keyboardType: widget.textInputType,
            obscureText: widget.obscureText!,
            cursorColor: Theme.of(context).primaryColor,
            validator: widget.validationFunction,
            readOnly: widget.readonly!,
            style: TextStyle(color: Colors.black, fontSize: 16.wp),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  left: 10,
                  top: widget.maxlines > 1 ? 10 : 0,
                  bottom: widget.maxlines > 1 ? 10 : 0,
                  right: 10,
                ),
                hintText: widget.hintText,
                counterText: "",
                errorStyle: _txt.bodyMedium!,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(10.wp),
                ),
                fillColor: const Color(0xffF9F8F7),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.wp),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.wp),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.wp),
                ),
                hintStyle: _txt.headlineSmall!
                    .copyWith(color: Colors.black.withOpacity(0.2)),
                border: InputBorder.none,
                suffixIcon: widget.suffixIcon ?? Container(width: 1)),
          ),
        ),
        SizedBox(height: 24.wp)
      ],
    );
  }
}
