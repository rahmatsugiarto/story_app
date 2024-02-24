import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final void Function()? onPressed;
  final Widget? child;

  const CustomButton({
    super.key,
    this.width,
    this.height,
    this.backgroundColor = Colors.black,
    this.foregroundColor = Colors.white,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          disabledBackgroundColor: Colors.grey[300],
          disabledForegroundColor: Colors.grey,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
