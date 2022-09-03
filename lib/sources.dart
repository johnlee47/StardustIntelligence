import 'package:abyss/source.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sources.g.dart';

@JsonSerializable()
class Sources {
  final bool success;
  final int? found;
  final int? password;
  final List<Source> sources;

  Sources({
    required this.success,
    required this.found,
    required this.password,
    required this.sources,
  });

  factory Sources.fromJson(Map<String, dynamic> json) =>
      _$SourcesFromJson(json);
}