import 'package:json_annotation/json_annotation.dart';
import 'package:medi_care_hub/features/auth/domain/entities/user_entity.dart';

import 'data.dart';

part 'signin_user_model.g.dart';

@JsonSerializable()
class SigninUserModel extends UserEntity {
  final String? message;
  final Data? data;
  final bool? status;
  final int? code;

  SigninUserModel(this.message, this.data, this.status, this.code)
      : super(username: data?.username ?? '');

  factory SigninUserModel.fromJson(Map<String, dynamic> json) {
    return _$SigninUserModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SigninUserModelToJson(this);
}
