import 'package:flutter/material.dart';

class CustomAppButton extends StatelessWidget {
  final Widget? child;
  final double borderRadius;
  final GestureTapCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderSide border;
  final Color? color;
  final double elevation;

  const CustomAppButton({
    Key? key,
    this.child,
    this.borderRadius = 0,
    this.onTap,
    this.padding,
    this.border = BorderSide.none,
    this.color,
    this.margin,
    this.elevation = 5
  }) : super(key: key);


  // const CustomAppButton.primary({
  //   Key? key,
  //   this.child,
  //   this.borderRadius = 0,
  //   this.onTap,
  //   this.padding,
  //   this.border = BorderSide.none,
  //   this.margin,
  //   this.color = AppColors.primary,
  //   this.elevation = 0
  // }) : super(key: key);


  static BorderSide get none => BorderSide(color: Colors.transparent);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Material(
        elevation: elevation,
        color: color,//??Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: border,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            padding: padding,
            child: child,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}

class CustomAppButtonPrimary extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap;

  const CustomAppButtonPrimary({Key? key,required this.text,required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomAppButton(
      color: Theme.of(context).colorScheme.secondary,
      onTap: onTap,
      child: Center(
        child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 14
          ),),
      ),
      borderRadius: 18,
      elevation: 0,
      // padding: EdgeInsets.symmetric(
      //   vertical: 16
      // ),
    );
  }
}