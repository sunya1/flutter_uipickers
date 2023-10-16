import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickers/src/hcb_cupertino_date_picker.dart';
import 'hcb_material_date_picker.dart';
import 'hcb_date_picker_mode.dart';

/// An adaptive widget for selecting from a date or time.
///
/// A popup lets the user select from a date or time. The widget
/// shows the currently selected value.
///
/// When used on iOS and when its type is set to adaptive or cupertino, it will show
/// a native iOS 14 style UIDatePicker in its popup.
///
/// When used on any other operating system or when the type is set to material, it
/// will use the default material dialog for selecting date or time.
///
/// The [onChanged] callback should update a state variable that defines the
/// picker's value. It should also call [State.setState] to rebuild the
/// picker with the new value.
///
class HCBAdaptiveDatePicker extends StatelessWidget {
  HCBAdaptiveDatePicker(
      {Key? key,
      this.mode = HCBAdaptiveDatePickerMode.date,
      required this.initialDate,
      required this.firstDate,
      required this.lastDate,
      required this.onChanged,
      this.onEndEdit,
      this.textColor,
      this.backgroundColor,
      this.borderColor,
      this.tintColor,
      this.borderWidth,
      this.cornerRadius,
      this.fontSize})
      : super(key: key);

  /// The initially selected date. It must either fall between these dates, or be equal to one of them.
  final DateTime initialDate;

  /// The earliest allowable date.
  final DateTime firstDate;

  /// The latest allowable date.
  final DateTime lastDate;

  /// Determines whether to use Date or Time selector popups.
  final HCBAdaptiveDatePickerMode mode;

  /// Called when the user selects a date/time.
  final void Function(DateTime)? onChanged;
  final void Function(DateTime)? onEndEdit;

  /// The color to use when painting the text.
  final Color? textColor;

  /// The text color to use when the picker is highlighted.
  final Color? tintColor;

  /// The color to fill in the background of the picker.
  final Color? backgroundColor;

  /// The color to use when painting the bordr of the picker.
  final Color? borderColor;

  /// The border width.
  final double? borderWidth;

  /// The corner radius.
  final double? cornerRadius;

  /// The font size of the selected item text.
  final double? fontSize;

  /// The date picker type to use. It is adaptive by default.
  /// When set to cupertino or adaptive it will instantinate a native platform picker when used with iOS.

  @override
  Widget build(BuildContext context) {
    var isIos = Platform.isIOS;
    if (isIos) {
      return TextButton(
          onPressed: () {
            showCupertinoDialog(
                context: context,
                barrierDismissible: true,
                builder: (_) => Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: _buildCupertinoNativeDatePicker(context)));
          },
          child: Text(
            "Show Dialog",
            style: TextStyle(fontSize: 24, color: Colors.black),
          ));
    }
    return _buildMaterialDatePicker(context);
  }

  Widget _buildMaterialDatePicker(BuildContext context) {
    return MaterialDatePicker(
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      onChanged: onChanged,
      mode: mode,
      textColor: textColor,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      cornerRadius: cornerRadius,
      fontSize: fontSize,
    );
  }

  Widget _buildCupertinoNativeDatePicker(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 350,
      child: HCBCupertinoDatePicker(
          mode: mode == HCBAdaptiveDatePickerMode.date
              ? HCBCupertinoDatePickerMode.date
              : HCBCupertinoDatePickerMode.time,
          selectedDate: initialDate,
          minimumDate: firstDate,
          maximumDate: lastDate,
          onChanged: (date) {
            onChanged?.call(date);
          },
          textColor: textColor,
          backgroundColor: Colors.white,
          borderColor: borderColor,
          borderWidth: borderWidth,
          cornerRadius: cornerRadius,
          fontSize: fontSize,
          tintColor: tintColor),
    );
  }
}
