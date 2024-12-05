import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/content/content.dart';
import 'package:survey_kit/src/view/widget/content/svg_widget.dart';

part 'svg_content.g.dart';

@JsonSerializable()
class SvgContent extends Content {
  static const type = 'svg';

  final String assetName;
  final BoxFit fit;
  final double? width;
  final double? height;

  const SvgContent({
    super.id,
    required this.assetName,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
  }) : super(contentType: type);

  factory SvgContent.fromJson(Map<String, dynamic> json) =>
      _$SvgContentFromJson(json);

  Map<String, dynamic> toJson() => _$SvgContentToJson(this);

  @override
  Widget createWidget() {
    return SvgWidget(
      svgContent: this,
    );
  }
}
