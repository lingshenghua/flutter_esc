// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceListModel _$DeviceListModelFromJson(Map<String, dynamic> json) =>
    DeviceListModel(
      deviceName: json['deviceName'] as String? ?? "",
      deviceAddress: json['deviceAddress'] as String? ?? "",
    );

Map<String, dynamic> _$DeviceListModelToJson(DeviceListModel instance) =>
    <String, dynamic>{
      'deviceName': instance.deviceName,
      'deviceAddress': instance.deviceAddress,
    };
