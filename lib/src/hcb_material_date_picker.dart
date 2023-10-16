import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pickers/src/hcb_date_picker_mode.dart';

/// A material widget for selecting a date or time.
///
/// A popup lets the user select a date or time. The widget
/// shows the currently selected value.
///
/// The [onChanged] callback should update a state variable that defines the
/// picker's value. It should also call [State.setState] to rebuild the
/// picker with the new value.
///
class MaterialDatePicker extends StatefulWidget {
  MaterialDatePicker(
      {Key? key,
      this.mode = HCBAdaptiveDatePickerMode.date,
      required this.initialDate,
      required this.firstDate,
      required this.lastDate,
      required this.onChanged,
      this.textColor,
      this.backgroundColor,
      this.borderColor,
      this.borderWidth,
      this.cornerRadius,
      this.fontSize})
      : super(key: key);

  final DateTime initialDate;

  final DateTime firstDate;

  final DateTime lastDate;

  final void Function(DateTime)? onChanged;

  final HCBAdaptiveDatePickerMode mode;

  final Color? textColor;

  final Color? backgroundColor;

  final Color? borderColor;

  final double? borderWidth;

  final double? cornerRadius;

  final double? fontSize;

  @override
  State<MaterialDatePicker> createState() => _MaterialDatePickerState();
}

class _MaterialDatePickerState extends State<MaterialDatePicker> {
  static final dateFormat = DateFormat('MMM dd, yyyy');
  static final timeFormat = DateFormat('hh:mm a');
  var date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    date = widget.initialDate;
    final textStyle = TextStyle(
        color: widget.textColor ?? Colors.black,
        fontSize: widget.fontSize ?? 17,
        fontWeight: FontWeight.w400);

    final formattedText = widget.mode == HCBAdaptiveDatePickerMode.date
        ? dateFormat.format(date)
        : timeFormat.format(date);

    return Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.cornerRadius ?? 8.0),
            side: BorderSide(
                color: widget.borderColor ?? Colors.transparent,
                width: widget.borderWidth ?? 0)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
            onTap: () async {
              if (widget.mode == HCBAdaptiveDatePickerMode.time) {
                var t = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay(hour: date.hour, minute: date.minute));
                if (t != null && widget.onChanged != null) {
                  setState(() {
                    date = DateTime(
                        date.year, date.month, date.day, t.hour, t.minute);
                    widget.onChanged!(date);
                  });
                }
              } else {
                var d = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: widget.firstDate,
                    lastDate: widget.lastDate);
                if (d != null && widget.onChanged != null) {
                  setState(() => date = d);
                  widget.onChanged!(d);
                }
              }
            },
            child: Ink(
              color: widget.backgroundColor ?? Color(0xFFEAEAEB),
              child: Center(child: Text(formattedText, style: textStyle)),
            )));
  }
}
