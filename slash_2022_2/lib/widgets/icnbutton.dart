// Packages
import 'package:flutter/material.dart';
import 'package:tinycolor2/tinycolor2.dart';

class IcnButton extends StatefulWidget {
  const IcnButton(
      {super.key,
      this.icondata,
      this.onPressed,
      this.size,
      this.margin,
      this.padding,
      this.colorchangeduration = const Duration(milliseconds: 140),
      this.color = Colors.black});

  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Duration colorchangeduration;
  final Color color;
  final IconData? icondata;
  final void Function()? onPressed;
  final double? size;

  @override
  State<IcnButton> createState() => _IcnButtonState();
}

class _IcnButtonState extends State<IcnButton>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation? _colorTween;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: widget.colorchangeduration);
    _colorTween = ColorTween(
            begin: widget.color,
            end: TinyColor.fromColor(widget.color).setOpacity(0.5).color)
        .animate(_animationController!);

    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: widget.margin ?? const EdgeInsets.only(),
        child: AnimatedBuilder(
            animation: _colorTween!,
            builder: (context, child) => Listener(
                onPointerDown: (details) {
                  _animationController!.forward();
                },
                onPointerUp: (details) {
                  _animationController!.reverse();

                  if (widget.onPressed != null) {
                    widget.onPressed!();
                  }
                },
                child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                        padding: widget.padding,
                        height: widget.size,
                        width: widget.size,
                        child: FittedBox(
                            child: Icon(widget.icondata,
                                color: _colorTween!.value)))))));
  }
}
