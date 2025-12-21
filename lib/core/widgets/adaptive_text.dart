import 'package:flutter/material.dart';
import '../responsive/responsive_layout.dart';

/// A Text widget that scales its font size based on the device type.
class AdaptiveText extends StatelessWidget {
  const AdaptiveText(
    this.data, {
    super.key,
    this.style,
    this.textAlign,
    this.mobileFontSize,
    this.tabletFontSize,
    this.desktopFontSize,
    this.maxLines,
    this.overflow,
  });

  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final double? mobileFontSize;
  final double? tabletFontSize;
  final double? desktopFontSize;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildText(context, mobileFontSize),
      tablet: _buildText(context, tabletFontSize ?? mobileFontSize),
      desktop: _buildText(context, desktopFontSize ?? tabletFontSize ?? mobileFontSize),
    );
  }

  Widget _buildText(BuildContext context, double? fontSize) {
    final defaultStyle = DefaultTextStyle.of(context).style;
    final effectiveStyle = style ?? defaultStyle;
    
    // Scale factor could be added here if needed, but explicit sizes are safer
    final finalStyle = fontSize != null 
        ? effectiveStyle.copyWith(fontSize: fontSize) 
        : effectiveStyle;

    return Text(
      data,
      style: finalStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
