import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/content/content.dart';
import 'package:survey_kit/src/view/widget/content/spacer_widget.dart';

part 'spacer_content.g.dart';

@JsonSerializable()
class SpacerContent extends Content {
  static const type = 'spacer';
  final double height;

  const SpacerContent({
    required this.height,
    super.id,
  }) : super(contentType: type);

  factory SpacerContent.fromJson(Map<String, dynamic> json) =>
      _$SpacerContentFromJson(json);

  Map<String, dynamic> toJson() => _$SpacerContentToJson(this);

  @override
  Widget createWidget() {
    return SpacerWidget(spacerContent: this);
  }
}
