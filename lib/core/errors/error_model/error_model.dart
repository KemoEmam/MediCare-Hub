import 'package:json_annotation/json_annotation.dart';

part 'error_model.g.dart';

@JsonSerializable()
class ErrorModel {
  final String? message;
  @JsonKey(name: 'data')
  final dynamic errors;
  final bool? status;
  final int? code;

  const ErrorModel({this.message, this.errors, this.status, this.code});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return _$ErrorModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ErrorModelToJson(this);

  String getAllErrorMessages() {
    if (errors != null && errors!.isNotEmpty) {
      return errors!.entries
          .map((entry) => entry.value is List
              ? (entry.value as List).join('\n')
              : entry.value.toString())
          .join('\n');
    }
    return message ?? "Unknown error occurred";
  }
}
