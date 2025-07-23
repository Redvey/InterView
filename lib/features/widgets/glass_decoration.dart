import 'package:flutter/material.dart';


class Glass extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final double padding;
  const Glass({super.key, required this.child, this.height, this.width,required this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.white.withAlpha(128),
        ),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        color: Colors.white.withAlpha(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            offset: const Offset(0, 7.62),
            blurRadius: 22.85,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(padding:  EdgeInsets.all(padding),
      child: child),
    );
  }
}
