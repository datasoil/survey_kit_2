// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'svg_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SvgContent _$SvgContentFromJson(Map<String, dynamic> json) => SvgContent(
      id: json['id'] as String?,
      assetName: json['assetName'] as String,
      fit: $enumDecodeNullable(_$BoxFitEnumMap, json['fit']) ?? BoxFit.contain,
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SvgContentToJson(SvgContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'assetName': instance.assetName,
      'fit': _$BoxFitEnumMap[instance.fit]!,
      'width': instance.width,
      'height': instance.height,
    };

const _$BoxFitEnumMap = {
  BoxFit.fill: 'fill',
  BoxFit.contain: 'contain',
  BoxFit.cover: 'cover',
  BoxFit.fitWidth: 'fitWidth',
  BoxFit.fitHeight: 'fitHeight',
  BoxFit.none: 'none',
  BoxFit.scaleDown: 'scaleDown',
};
