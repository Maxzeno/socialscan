import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialscan/utils/colors.dart';

class ButtonTile extends StatelessWidget {
  final String text;
  final Color? textColor;

  final double boxRadius;
  final double? width;
  final Widget? icon;
  final Color? color;
  final bool? loading;
  final VoidCallback? onTap;

  const ButtonTile({
    Key? key,
    required this.text,
    required this.boxRadius,
    this.width,
    this.icon,
    this.textColor,
    this.color,
    this.onTap,
    this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 54,
        width: width ?? 388,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(boxRadius),
          color: color ?? ProjectColors.mainPurple,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(width: 10),
              ],
              loading == true
                  ? _buildLoadingIndicator()
                  : Text(
                      text,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: textColor ?? Colors.white,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const SizedBox(
      width: 55.0,
      height: 24.0,
      child: SpinKitThreeBounce(
        color: Colors.white,
        size: 24.0,
      ),
    );
  }
}
