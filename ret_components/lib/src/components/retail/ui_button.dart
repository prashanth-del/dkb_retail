import 'package:flutter/material.dart';

import '../../../db_uicomponents.dart';


enum _ButtonType {
  primary,
  secondary,
  gradient,
  flat, // New button type
}

class UIButton extends StatefulWidget {
  final String? label;
  final Widget? child;
  final VoidCallback? onPressed;
  final EdgeInsets? margin;
  final bool isDisabled;
  final bool isSmallButton;
  final double? width;
  final double? height;
  final double? btnCurve;
  final Gradient? gradient;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? txtColor;
  final double? txtSize;
  final String? iconPath;
  final FocusNode? focus;

  final bool isRoundedButton;
  final double? maxWidth;

  const UIButton.primary({
    required this.onPressed,
    this.label,
    this.child,
    this.isDisabled = false,
    this.isSmallButton = false,
    this.width,
    this.txtSize,
    this.height,
    this.isRoundedButton = false,
    this.margin,
    this.txtColor,
    this.gradient,
    this.focus,
    super.key,
    this.backgroundColor,
    this.borderColor,
    this.maxWidth,
  })  : _buttonType = _ButtonType.primary,
        _isAnimated = true,
        iconPath = null,
        btnCurve = null,
        _buttonShape = const RoundedRectangleBorder(
          borderRadius: Corners.s8Border,
        );

  const UIButton.secondary({
    required this.label,
    required this.onPressed,
    this.isDisabled = false,
    this.isSmallButton = false,
    this.isRoundedButton = false,
    this.margin,
    this.width,
    this.height,
    this.child,
    this.txtSize,
    this.txtColor,
    this.gradient,
    this.focus,
    super.key,
    this.backgroundColor,
    this.borderColor,
    this.maxWidth,
  })  : _buttonType = _ButtonType.secondary,
        _isAnimated = true,
        iconPath = null,
        btnCurve = null,
        _buttonShape = const RoundedRectangleBorder(
          borderRadius: Corners.s8Border,
        );

  const UIButton.rounded({
    required this.onPressed,
    this.label,
    this.child,
    this.isDisabled = false,
    this.isSmallButton = false,
    this.isRoundedButton = true,
    this.btnCurve,
    this.margin,
    this.txtSize,
    this.width,
    this.height,
    this.txtColor,
    this.gradient,
    this.focus,
    super.key,
    this.backgroundColor,
    this.borderColor,
    this.maxWidth,
  })  : _buttonType = _ButtonType.primary,
        _isAnimated = true,
        iconPath = null,
        _buttonShape = const RoundedRectangleBorder(
          borderRadius: Corners.s4Border,
        );

  const UIButton.gradient({
    super.key,
    required this.onPressed,
    required this.gradient,
    this.label,
    this.child,
    this.isDisabled = false,
    this.isSmallButton = false,
    this.isRoundedButton = false,
    this.margin,
    this.txtSize,
    this.width,
    this.height,
    this.txtColor,
    this.backgroundColor,
    this.borderColor,
    this.maxWidth,
    this.focus,
  })  : _buttonType = _ButtonType.gradient,
        _isAnimated = true,
        iconPath = null,
        btnCurve = null,
        _buttonShape = const RoundedRectangleBorder(
          borderRadius: Corners.s8Border,
        );

  const UIButton.flat({
    required this.onPressed,
    this.label,
    this.child,
    this.isDisabled = false,
    this.isSmallButton = false,
    this.margin,
    this.txtSize,
    this.width,
    this.height,
    this.btnCurve,
    this.txtColor,
    this.backgroundColor,
    this.borderColor,
    this.maxWidth,
    this.iconPath,
    this.focus,
    super.key,
    this.gradient,
    this.isRoundedButton = false, // Default to false for flat buttons
  })  : _buttonType = _ButtonType.flat,
        _isAnimated = false,
        _buttonShape =
        const RoundedRectangleBorder(); // Flat button has no border radius

  final bool _isAnimated;
  final _ButtonType _buttonType;
  final ShapeBorder _buttonShape;

  @override
  State<UIButton> createState() => _UIButtonState();
}

class _UIButtonState extends State<UIButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Color bgColor;
  late Color textColor;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _controller.addListener(() {
      setState(() {});
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  updateSurfaceColors({required BuildContext context}) {
    switch (widget._buttonType) {
      case _ButtonType.primary:
        bgColor = (widget.isDisabled || widget.onPressed == null)
            ? DefaultColors.grayB0
            : (widget.backgroundColor ?? context.colorScheme.primary);
        textColor = widget.txtColor ?? context.colorScheme.onPrimary;
        return;
      case _ButtonType.secondary:
        bgColor = (widget.isDisabled || widget.onPressed == null)
            ? DefaultColors.grayB0
            : (widget.backgroundColor ?? context.colorScheme.secondary);
        textColor = widget.txtColor ?? context.colorScheme.onSecondary;
        return;
      case _ButtonType.gradient:
        bgColor = (widget.isDisabled || widget.onPressed == null)
            ? DefaultColors.grayB0
            : Colors.transparent; // Example for gradient button
        textColor = widget.txtColor ?? Colors.white;
        return;
      case _ButtonType.flat:
        bgColor = (widget.isDisabled || widget.onPressed == null)
            ? DefaultColors.grayB0
            : (widget.backgroundColor ??
            Colors.transparent); // Flat button background
        textColor = widget.txtColor ??
            context.colorScheme.primary; // Text color for flat button
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    updateSurfaceColors(context: context);

    switch (widget._buttonType) {
      case _ButtonType.flat:
        final ButtonStyle flatButtonStyle = TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.all(Radius.circular(widget.btnCurve ?? 2.0)),
            side: BorderSide(color: widget.borderColor ?? DefaultColors.grayA7),
          ),
          backgroundColor: widget.backgroundColor ?? Colors.transparent,
          overlayColor: DefaultColors.transparent,
        );
        return SizedBox(
          height: widget.height, // Set default height
          child: TextButton(
            style: flatButtonStyle,
            focusNode: widget.focus,
            onPressed: widget.isDisabled ? null : widget.onPressed,
            child: widget.iconPath != null
                ? Row(children: [
              UiTextNew.b2Medium(
                widget.label ?? "Continue",
                color: textColor ?? DefaultColors.blue9B,
              ),
              UiSpace.horizontal(3),
              UISvgIcon(assetPath: widget.iconPath!),
            ])
                : UiTextNew.b2Medium(
              widget.label ?? "Continue",
              color: textColor ?? DefaultColors.blue9B,
            ),
          ),
        );
      default:
        return AnimatedContainer(
          constraints: BoxConstraints(
            maxWidth: widget.maxWidth ?? 150,
          ),
          height: widget.height ?? 42,
          width:
          widget.isSmallButton ? null : (widget.width ?? double.maxFinite),
          margin: widget.margin ?? const EdgeInsets.symmetric(vertical: 20),
          duration: const Duration(milliseconds: 200),
          decoration: widget._buttonType == _ButtonType.gradient
              ? BoxDecoration(
            gradient: widget.gradient,
            borderRadius: widget.isRoundedButton
                ? BorderRadius.circular(widget.btnCurve ?? 8.0)
                : null,
          )
              : BoxDecoration(
              color: bgColor,
              borderRadius: widget.isRoundedButton
                  ? BorderRadius.circular(widget.btnCurve ?? 8.0)
                  : BorderRadius.zero,
              border: Border.all(
                  color: widget.borderColor ?? DefaultColors.transparent)),
          child: MaterialButton(
            focusNode: widget.focus,
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            shape: widget._buttonShape,
            elevation: 0,
            color: widget._buttonType == _ButtonType.flat ? null : null,
            onPressed: widget.isDisabled
                ? null
                : () {
              if (widget._isAnimated) {
                _controller.forward();
                Future.delayed(const Duration(milliseconds: 350), () {
                  widget.onPressed?.call();
                });
              } else {
                widget.onPressed?.call();
              }
            },
            child: widget.child ??
                UiTextNew.b2Medium(
                  widget.label ?? "Continue",
                  color: textColor,
                ),
          ),
        );
    }
  }
}
