import 'package:dream_catcher/styles/styles.dart';
import 'package:flutter/material.dart';

/// Small button with label and optional icon.
class SimpleButton extends StatefulWidget {
  final Widget? child;
  final Widget? icon;
  final String? label;
  final GestureTapCallback? onPressed;
  final Color? color;
  final Color? textColor;
  final double? height;
  final double? width;
  final double? roundedRadius;
  final bool needToCenter;
  final Widget? trailing;
  final EdgeInsets? padding;
  final ButtonVariant buttonVariant;
  final double borderWidth;
  final double? textScaleFactor;
  final TextStyle? textStyle;

  const SimpleButton({
    Key? key,
    this.child,
    this.icon,
    this.label,
    this.onPressed,
    this.color,
    this.textColor,
    this.height,
    this.width,
    this.roundedRadius,
    this.needToCenter = true,
    this.trailing,
    this.padding,
    this.borderWidth = 1.0,
    this.buttonVariant = ButtonVariant.SECONDARY,
    this.textStyle,
    this.textScaleFactor = 1.0,
  }) : super(key: key);

  @override
  State<SimpleButton> createState() => _SimpleButtonState();
}

class _SimpleButtonState extends State<SimpleButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    Color buttonColor =
        ButtonVariant.getButtonVariantColors(widget.buttonVariant)["buttonColor"] ?? Styles.lavenderPurple;
    Color labelColor = ButtonVariant.getButtonVariantColors(widget.buttonVariant)["labelColor"] ?? Styles.white;
    Color borderColor =
        ButtonVariant.getButtonVariantColors(widget.buttonVariant)["borderColor"] ?? Styles.lavenderPurple;

    if (widget.color != null) {
      buttonColor = widget.color!;
      borderColor = widget.color!;
    }
    if (widget.textColor != null) labelColor = widget.textColor!;

    List<Widget> children = [];

    if (widget.child != null) children.add(widget.child!);
    if (widget.icon != null) children.add(widget.icon!);

    if (widget.label != null) {
      if (widget.icon != null) {
        children.add(Container(width: 5.0)); // add a spacer
      }
      children.add(
        widget.trailing == null
            ? Flexible(
                child: _labelTextWithStyle(widget.label!, labelColor),
              )
            : Expanded(
                child: _labelTextWithStyle(widget.label!, labelColor),
              ),
      );
    }
    if (widget.trailing != null) children.add(widget.trailing!);

    double horizPadding = widget.height != null ? (widget.height! * 0.3) : 12.0; // for text
    double verticalPadding = 0;
    return Listener(
      onPointerDown: (details) {
        setState(() {
          isPressed = true;
        });
      },
      onPointerUp: (details) {
        Future.delayed(const Duration(milliseconds: 150), () {
          if (mounted) setState(() => isPressed = false);
        });
      },
      child: InkWell(
          highlightColor: Colors.transparent,
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: Styles.waitTimeInMilliseconds),
            height: widget.height ?? 38.0,
            width: widget.width,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(widget.roundedRadius ?? 12.0)),
              border: Border.all(color: isPressed ? borderColor : Colors.transparent, width: widget.borderWidth),
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(widget.roundedRadius ?? 12.0)),
                  border: Border.all(color: Colors.transparent, width: widget.borderWidth)),
              child: Container(
                height: widget.height ?? 38.0,
                width: widget.width,
                padding: widget.padding ??
                    EdgeInsets.fromLTRB(
                      widget.icon != null ? horizPadding - 4.0 : horizPadding,
                      verticalPadding,
                      horizPadding,
                      verticalPadding + 2.0,
                    ),
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.all(Radius.circular(widget.roundedRadius ?? 12.0)),
                  border: Border.all(color: borderColor, width: widget.borderWidth),
                ),
                child: widget.needToCenter
                    ? Center(
                        child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: children,
                      ))
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: children,
                      ),
              ),
            ),
          )),
    );
  }

  Widget _labelTextWithStyle(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Text(
        label,
        style: widget.textStyle ?? Styles.uiSemiBoldMedium.copyWith(color: color),
        textScaleFactor: widget.textScaleFactor,
      ),
    );
  }
}

class ButtonVariant {
  final String _value;
  const ButtonVariant._internal(this._value);
  @override
  toString() => _value;

  static ButtonVariant disabled(ButtonVariant? variant) {
    switch (variant) {
      case ButtonVariant.SECONDARY:
        return ButtonVariant.SECONDARY_DISABLED;
      case ButtonVariant.TERTIARY:
        return ButtonVariant.TERTIARY_DISABLED;
      default:
        return ButtonVariant.PRIMARY_DISABLED;
    }
  }

  static Map<String, Color> getButtonVariantColors(ButtonVariant variant) {
    switch (variant) {
      case ButtonVariant.SECONDARY:
        return {'buttonColor': Styles.deepOceanBlue, 'labelColor': Styles.white, 'borderColor': Styles.white};
      case ButtonVariant.TERTIARY:
        return {'buttonColor': Styles.white, 'labelColor': Styles.white, 'borderColor': Styles.white};
      case ButtonVariant.OUTLINED:
        return {'buttonColor': Colors.transparent, 'labelColor': Styles.white, 'borderColor': Styles.white};
      case ButtonVariant.SECONDARY_DISABLED:
        return {'buttonColor': Styles.white, 'labelColor': Styles.white, 'borderColor': Styles.white};
      case ButtonVariant.TERTIARY_DISABLED:
        return {'buttonColor': Styles.white, 'labelColor': Styles.white, 'borderColor': Styles.white};
      case ButtonVariant.OUTLINED_DISABLED:
        return {'buttonColor': Colors.transparent, 'labelColor': Styles.white, 'borderColor': Styles.white};
      case ButtonVariant.PRIMARY:
      default:
        return {'buttonColor': Styles.deepOceanBlue, 'labelColor': Styles.white, 'borderColor': Styles.deepOceanBlue};
    }
  }

  factory ButtonVariant.fromString(String value) {
    switch (value) {
      case 'YELLOW':
        return YELLOW;
      case 'SECONDARY':
        return SECONDARY;
      case 'TERTIARY':
        return TERTIARY;
      case 'OUTLINED':
        return OUTLINED;
      case 'PRIMARY_DISABLED':
        return PRIMARY_DISABLED;
      case 'SECONDARY_DISABLED':
        return SECONDARY_DISABLED;
      case 'TERTIARY_DISABLED':
        return TERTIARY_DISABLED;
      case 'OUTLINED_DISABLED':
        return OUTLINED_DISABLED;
      case 'PRIMARY':
      default:
        return PRIMARY;
    }
  }

  static const YELLOW = ButtonVariant._internal('YELLOW');
  static const PRIMARY = ButtonVariant._internal('PRIMARY');
  static const SECONDARY = ButtonVariant._internal('SECONDARY');
  static const TERTIARY = ButtonVariant._internal('TERTIARY');
  static const OUTLINED = ButtonVariant._internal('OUTLINED');
  static const PRIMARY_DISABLED = ButtonVariant._internal('PRIMARY_DISABLED');
  static const SECONDARY_DISABLED = ButtonVariant._internal('SECONDARY_DISABLED');
  static const TERTIARY_DISABLED = ButtonVariant._internal('TERTIARY_DISABLED');
  static const OUTLINED_DISABLED = ButtonVariant._internal('OUTLINED_DISABLED');
}
