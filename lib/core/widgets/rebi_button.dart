import 'package:flutter/material.dart';

import '../constants/colors/app_colors.dart';

class RebiButton extends StatefulWidget {

  const RebiButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    this.backgroundColor = AppColors.white,
    this.width,
    this.height = 50,
    this.elevation = 0,
    this.shadowColor = AppColors.gold,
    this.radius = 10.0,
    this.isBackButton=false,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget child;
  final Color backgroundColor;
  final double? width;
  final double height;
  final double? elevation;
  final Color shadowColor;
  final double radius;
  final bool isBackButton;

  @override
  State<RebiButton> createState() => _RebiButtonState();
}

class _RebiButtonState extends State<RebiButton> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.isLoading,
      child: ElevatedButton(
        onPressed: () {
          if (widget.isLoading) {
            return;
          }
          widget.onPressed!();
        },
        style: widget.isBackButton?ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor,

          side: const BorderSide(
              width: 2, // the thickness
              color:  AppColors.white,
          ),
          textStyle: const TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w500,
            fontFamily: "notosan",
            color: AppColors.white,
          ),
          shadowColor: widget.shadowColor,
          elevation: widget.elevation,
          minimumSize: widget.width != null ? Size(widget.width!, widget.height) : null,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.radius),
            ),
          ),
        ):ElevatedButton.styleFrom(
          foregroundColor: AppColors.backgroundColor, backgroundColor: widget.backgroundColor,
          // side: const BorderSide(
          //     width: 2, // the thickness
          //     color: Colors.black // the color of the border
          // ),
          textStyle: const TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w500,
            fontFamily: "notosan",
            color: AppColors.white,
          ),
          shadowColor: widget.shadowColor,
          elevation: widget.elevation,
          minimumSize: widget.width != null ? Size(widget.width!, widget.height) : null,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.radius),
            ),
          ),
        ),
        child: Container(
          height: widget.height,
          width: widget.width,
          alignment: Alignment.center,
          child: widget.isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : widget.child,
        ),
      ),
    );
  }
}
