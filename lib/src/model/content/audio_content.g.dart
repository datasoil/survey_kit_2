// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioContent _$AudioContentFromJson(Map<String, dynamic> json) => AudioContent(
      url: json['url'] as String,
      id: json['id'] as String?,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      externalLink: json['externalLink'] as String?,
    );

Map<String, dynamic> _$AudioContentToJson(AudioContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'externalLink': instance.externalLink,
    };
