import 'package:dream_catcher/styles/styles.dart';
import 'package:flutter/material.dart';

// Base style for all cards.  Lowest common denominator Card.
class DreamCard extends StatefulWidget {
  final Widget child;
  final bool active;
  final GestureTapCallback? onTap;
  final Color? color;
  final double? width;
  final EdgeInsets? padding;
  final bool unread;
  final double? height;
  final bool hasShadow;

  const DreamCard(
      {Key? key,
      this.onTap,
      required this.child,
      this.active = false,
      this.color,
      this.width,
      this.height,
      this.padding = const EdgeInsets.all(10),
      this.unread = false,
      this.hasShadow = false})
      : super(key: key);

  @override
  State<DreamCard> createState() => _DreamCardState();
}

class _DreamCardState extends State<DreamCard> {
  bool isActive = false;

  @override
  void initState() {
    super.initState();
    isActive = widget.active;
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = isActive ? Styles.white.withOpacity(0.75) : widget.color ?? Styles.white;

    Widget child;
    if (widget.unread || isActive) {
      double indicatorMargin = 20;
      if (widget.height != null) {
        indicatorMargin = widget.height! / 3;
      } else if (widget.padding != null && widget.padding != EdgeInsets.zero) {
        indicatorMargin = widget.padding!.top * 2;
      }
      child = Stack(
        clipBehavior: Clip.none, // This prevents the card's drop shadows from being clipped.
        children: [
          if (widget.unread)
            Positioned(
              right: 10,
              top: 7,
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: Styles.deepOceanBlue, shape: BoxShape.circle),
                constraints: const BoxConstraints(
                  minWidth: Styles.badgeSize - 4,
                  minHeight: Styles.badgeSize - 4,
                ),
              ),
            ),
          if (isActive)
            Positioned(
              right: 10,
              top: indicatorMargin,
              bottom: indicatorMargin,
              child: Container(
                width: 3,
                alignment: Alignment.centerRight,
                decoration:
                    const BoxDecoration(color: Styles.white, borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
          Container(
            clipBehavior: Clip.none, // This prevents the card's drop shadows from being clipped.
            padding: widget.padding,
            child: widget.child,
          ),
        ],
      );
    } else {
      child = Container(
        clipBehavior: Clip.none, // This prevents the card's drop shadows from being clipped.
        padding: widget.padding,
        child: widget.child,
      );
    }

    return InkWell(
        hoverColor: Colors.transparent,
        onTap: widget.onTap,
        child: Container(
          height: widget.height,
          clipBehavior: Clip.none, // This prevents the card's drop shadows from being clipped.
          width: widget.width,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(Styles.pillRoundCorner),
            boxShadow: widget.hasShadow ? Styles.cardInactiveShadow : null,
          ),
          child: child,
        ));
  }
}
