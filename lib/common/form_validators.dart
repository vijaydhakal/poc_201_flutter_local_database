import 'package:poc_flutter/common/util/check_empty_utils.dart';

class FormValidator {
  static String? validateEmptyString(String? text, String fieldName) {
    if (!CheckEmptyUtils.checkEmpty(text)) {
      return null;
    } else {
      return "$fieldName  Required";
    }
  }
}
