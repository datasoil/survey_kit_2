import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/content/audio_content.dart';
import 'package:survey_kit/src/model/content/image_content.dart';
import 'package:survey_kit/src/model/content/lottie_content.dart';
import 'package:survey_kit/src/model/content/markdown_content.dart';
import 'package:survey_kit/src/model/content/svg_content.dart';
import 'package:survey_kit/src/model/content/text_content.dart';
import 'package:survey_kit/src/model/content/video_content.dart';

@JsonSerializable()
abstract class Content {
  final String? id;
  @JsonKey(name: 'type')
  final String contentType;

  const Content({
    this.id,
    required this.contentType,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String?;
    assert(type != null, 'type is required');

    switch (type) {
      case AudioContent.type:
        return AudioContent.fromJson(json);
      case TextContent.type:
        return TextContent.fromJson(json);
      case VideoContent.type:
        return VideoContent.fromJson(json);
      case MarkdownContent.type:
        return MarkdownContent.fromJson(json);
      case LottieContent.type:
        return LottieContent.fromJson(json);
      case SvgContent.type:
        return SvgContent.fromJson(json);
      case ImageContent.type:
        return ImageContent.fromJson(json);
      default:
        throw Exception('Unknown type: $type');
    }
  }

  Widget createWidget();
}
