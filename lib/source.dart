import 'package:json_annotation/json_annotation.dart';

part 'source.g.dart';

@JsonSerializable()
class Source {
  /// The generated code assumes these values exist in JSON.
  final String name;
  final String date;

  /// The generated code below handles if the corresponding JSON value doesn't
  /// exist or is empty.

  Source({required this.name, required this.date});

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SourceToJson(this);
}