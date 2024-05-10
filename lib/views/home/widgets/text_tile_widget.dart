  import 'package:flutter/material.dart';

class TextTileWidget extends StatelessWidget {
  const TextTileWidget({super.key, this.text, this.icon, this.size});
 final String? text;
 final Widget? icon; 
 final double? size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text!,
          style: TextStyle(
            fontSize: size ?? 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        // icon!,
      ],
    );
  }
}