import 'dart:async';

import 'package:dream_catcher/widgets/simple_button.dart';
import 'package:flutter/material.dart';

class AsyncActionButton extends StatefulWidget {
  final String? label;
  final Color? color;
  final Color? textColor;
  final Widget? icon;
  final double? width;
  final double? height;
  final Function? onPressed;
  final Function? onCompleted;
  final bool isDelete;
  final bool reset;
  final bool needToCenter;
  final bool isSaving;
  final TextStyle? customStyle;
  final double? roundedRadius;
  final AsyncButtonController? controller;
  final ButtonVariant? buttonVariant;

  /// The amount of time that the success checkmark should be shown, in milliseconds.
  final int successDelay;

  AsyncActionButton({
    Key? key,
    this.label,
    this.color,
    this.textColor,
    this.icon,
    this.height,
    this.width,
    this.onPressed,
    this.onCompleted,
    this.isDelete = false,
    this.needToCenter = true,
    this.reset = false,
    this.isSaving = false,
    this.roundedRadius,
    this.customStyle,
    this.controller,
    this.buttonVariant,
    this.successDelay = 1000,
  }) : super(key: key ?? ValueKey((label?.hashCode ?? 0) + (color?.value ?? 0) + (onPressed?.hashCode ?? 0)));

  @override
  State<AsyncActionButton> createState() => _AsyncActionButtonState();
}

enum ButtonState {
  NOT_PRESSED,
  IN_PROGRESS,
  FINISHED,
}

class _AsyncActionButtonState extends State<AsyncActionButton> {
  var _buttonState = ButtonState.NOT_PRESSED;
  late ButtonVariant _buttonVariant;

  @override
  void initState() {
    super.initState();
    _buttonState = ButtonState.NOT_PRESSED;
    widget.controller?.setListener(() => _handlePress());

    if (widget.onPressed == null) {
      _buttonVariant = widget.buttonVariant != null
          ? ButtonVariant.disabled(widget.buttonVariant)
          : ButtonVariant.SECONDARY_DISABLED;
    } else if (widget.isDelete) {
      _buttonVariant = widget.buttonVariant ?? ButtonVariant.SECONDARY;
    } else {
      _buttonVariant = widget.buttonVariant ?? ButtonVariant.SECONDARY;
    }

    if (widget.buttonVariant != null) {
      _buttonVariant = widget.buttonVariant!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleButton(
      label: _getChild() == null ? widget.label : null,
      icon: widget.icon,
      height: widget.height,
      width: widget.width,
      needToCenter: widget.needToCenter,
      roundedRadius: widget.roundedRadius,
      buttonVariant: _buttonVariant,
      onPressed: (widget.onPressed == null || _buttonState == ButtonState.IN_PROGRESS) ? null : _handlePress,
      child: _getChild(),
    );
  }

  Widget? _getChild() {
    if (_buttonState == ButtonState.IN_PROGRESS) {
      return SizedBox(
        height: (widget.height ?? 38.0) * 0.65,
        width: (widget.height ?? 38.0) * 0.65,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              ButtonVariant.getButtonVariantColors(_buttonVariant)["labelColor"]!,
            ),
          ),
        ),
      );
    } else if (_buttonState == ButtonState.NOT_PRESSED) {
      return null;
    } else {
      // completed
      return Icon(
        Icons.check,
        size: (widget.height ?? 38.0) * 0.65,
        color: ButtonVariant.getButtonVariantColors(_buttonVariant)["labelColor"]!,
      );
    }
  }

  Future<void> _handlePress() async {
    if (widget.onPressed == null) return;

    if (mounted) {
      setState(() {
        _buttonState = ButtonState.IN_PROGRESS;
      });
    }
    var result = await widget.onPressed!.call();
    if (mounted) {
      setState(() {
        _buttonState = ButtonState.FINISHED;
      });
    }
    if (widget.reset) {
      _buttonState = ButtonState.NOT_PRESSED;
    }
    if (widget.onCompleted != null) {
      Timer(Duration(milliseconds: widget.successDelay), () {
        if (mounted) widget.onCompleted!.call(result);
      });
    }
    // if (widget.isSaving) {
    //   setState(() {
    //     _buttonState = _BUTTON_STATE.IN_PROGRESS;
    //   });
    // }
  }
}

class AsyncButtonController {
  VoidCallback? callback;
  void triggerPressed() => callback?.call();
  void setListener(VoidCallback callback) => this.callback = callback;
}
