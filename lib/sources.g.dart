// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sources.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sources _$SourcesFromJson(Map<String, dynamic> json) => Sources(
      success: json['success'] as bool,
      found: json['found'] as int?,
      password: json['password'] as int?,
      sources: (json['sources'] as List<dynamic>)
          .map((e) => Source.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SourcesToJson(Sources instance) => <String, dynamic>{
      'success': instance.success,
      'found': instance.found,
      'password': instance.password,
      'sources': instance.sources,
    };
