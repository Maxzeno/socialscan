import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final Widget icon;
  const OptionTile(
      {super.key, required this.text, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        // color: Colors.red,
        height: 40,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              icon,
            ],
          ),
        ),
      ),
    );
  }
}
