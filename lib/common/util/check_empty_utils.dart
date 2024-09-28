// ignore_for_file: avoid_classes_with_only_static_members

extension CheckEmptyExtension on dynamic {
  bool get checkEmpty {
    if (this == null) {
      return true;
    }

    final String d = toString();
    if (d == '' || d == '[]' || d == '{}') {
      return true;
    }
    return false;
  }
}

class CheckEmptyUtils {
  //check empty
  static bool checkEmpty(dynamic val) {
    if (val == null) {
      return true;
    }

    if (val == '' || val == '[]' || val == '{}') {
      return true;
    }
    return false;
  }
}
