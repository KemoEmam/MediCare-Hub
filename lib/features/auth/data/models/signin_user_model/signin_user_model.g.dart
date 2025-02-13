// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SigninUserModel _$SigninUserModelFromJson(Map<String, dynamic> json) =>
    SigninUserModel(
      json['message'] as String?,
      json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      json['status'] as bool?,
      (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SigninUserModelToJson(SigninUserModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
      'status': instance.status,
      'code': instance.code,
    };
