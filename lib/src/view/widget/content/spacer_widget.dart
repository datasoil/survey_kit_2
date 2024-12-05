import 'package:flutter/material.dart';
import 'package:survey_kit/src/model/content/spacer_content.dart';

class SpacerWidget extends StatelessWidget {
  const SpacerWidget({
    super.key,
    required this.spacerContent,
  });

  final SpacerContent spacerContent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: spacerContent.height);
  }
}
