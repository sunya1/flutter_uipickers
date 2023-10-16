import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

enum HCBCupertinoDatePickerMode { time, date, dateAndTime }

/// A wrapper around the native iOS 14 UIDatePicker that allows
/// selecting a date, time or date and time.
///
/// A popup lets the user select from a number of items. The widget
/// shows the currently selected item.
///
/// The [onChanged] callback should update a state variable that defines the
/// picker's value. It should also call [State.setState] to rebuild the
/// picker with the new value.
///
class HCBCupertinoDatePicker extends StatefulWidget {
  const HCBCupertinoDatePicker(
      {Key? key,
      this.mode = HCBCupertinoDatePickerMode.date,
      this.selectedDate,
      this.minimumDate,
      this.maximumDate,
      this.textColor,
      this.tintColor,
      this.backgroundColor,
      this.borderColor,
      this.borderWidth,
      this.cornerRadius,
      this.fontSize,
      this.onChanged})
      : super(key: key);

  final DateTime? selectedDate;

  final DateTime? maximumDate;

  final DateTime? minimumDate;

  final void Function(DateTime)? onChanged;

  final HCBCupertinoDatePickerMode mode;

  final Color? textColor;

  final Color? tintColor;

  final Color? backgroundColor;

  final Color? borderColor;

  final double? borderWidth;

  final double? cornerRadius;

  final double? fontSize;

  @override
  State<HCBCupertinoDatePicker> createState() => _HCBCupertinoDatePickerState();
}

class _HCBCupertinoDatePickerState extends State<HCBCupertinoDatePicker> {
  MethodChannel? _channel;

  @override
  Widget build(BuildContext context) {
    const String viewType = 'FLDatePicker';
    Map<String, dynamic> creationParams = <String, dynamic>{
      "mode": widget.mode.index,
    };
    if (widget.selectedDate != null) {
      creationParams["date"] = widget.selectedDate?.toIso8601String();
    }
    if (widget.minimumDate != null) {
      creationParams["minimumDate"] = widget.minimumDate?.toIso8601String();
    }
    if (widget.maximumDate != null) {
      creationParams["maximumDate"] = widget.maximumDate?.toIso8601String();
    }
    if (widget.textColor != null) {
      creationParams["textColor"] = widget.textColor?.value.toRadixString(16);
    }
    if (widget.tintColor != null) {
      creationParams["tintColor"] = widget.tintColor?.value.toRadixString(16);
    }
    if (widget.backgroundColor != null) {
      creationParams["backgroundColor"] =
          widget.backgroundColor?.value.toRadixString(16);
    }
    if (widget.borderColor != null) {
      creationParams["borderColor"] =
          widget.borderColor?.value.toRadixString(16);
    }
    if (widget.borderWidth != null) {
      creationParams["borderWidth"] = widget.borderWidth;
    }
    if (widget.cornerRadius != null) {
      creationParams["cornerRadius"] = widget.cornerRadius;
    }
    if (widget.fontSize != null) {
      creationParams["fontSize"] = widget.fontSize;
    }

    if (_channel != null) {
      _channel?.invokeMethod('setDate', widget.selectedDate?.toIso8601String());
      _channel?.invokeMethod(
          'setMinDate', widget.minimumDate?.toIso8601String());
    }

    return UiKitView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
      onPlatformViewCreated: (int id) {
        _channel = MethodChannel('FLDatePicker/$id');
        _channel?.setMethodCallHandler(_channelCallHandler);
      },
    );
  }

  Future<void> _channelCallHandler(MethodCall call) async {
    switch (call.method) {
      case 'onChanged':
        String text = call.arguments as String;
        DateTime date = DateTime.parse(text);
        if (widget.onChanged != null) {
          widget.onChanged!(date);
        }
        break;
    }
  }
}
