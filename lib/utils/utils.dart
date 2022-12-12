import 'package:enum_to_string/enum_to_string.dart';

convertEnumToString(dynamic enumItem) {
  return EnumToString.convertToString(enumItem).toLowerCase();
}
