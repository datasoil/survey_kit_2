import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:survey_kit/src/model/content/svg_content.dart';

class SvgWidget extends StatelessWidget {
  const SvgWidget({
    super.key,
    required this.svgContent,
  });

  final SvgContent svgContent;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svgContent.assetName,
      fit: svgContent.fit,
      width: svgContent.width,
      height: svgContent.height,
    );
  }
}
