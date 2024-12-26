import 'package:json_annotation/json_annotation.dart';

part 'device_list_model.g.dart';

/// 设备列表数据
@JsonSerializable()
class DeviceListModel {
  final String deviceName;
  final String deviceAddress;

  DeviceListModel({
    this.deviceName = "",
    this.deviceAddress = "",
  });

  factory DeviceListModel.formJson(Map<String, dynamic> json) => _$DeviceListModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceListModelToJson(this);
}
