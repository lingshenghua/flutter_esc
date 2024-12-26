import 'package:flutter/services.dart';
import 'package:flutter_esc/model/device_list_model.dart';

class EscPlugin {
  static const MethodChannel _channel = MethodChannel('com.kq.flutter_esc/plugin');

  /// 初始化
  Future<void> printerHelperInit() async {
    try {
      await _channel.invokeMethod('printerHelperInit');
    } catch (e) {
      throw 'Error: $e';
    }
  }

  /// 注册蓝牙广播
  Future<void> registerBroadcast() async {
    try {
      await _channel.invokeMethod('registerBroadcast');
    } catch (e) {
      throw 'Error: $e';
    }
  }

  /// 监听获取到的蓝⽛协议的打印机数据
  Future<void> listenForBluetoothDevices(Function(DeviceListModel deviceListModel) callback) async {
    try {
      _channel.setMethodCallHandler((call) async {
        if (call.method == 'forBluetoothDevices') {
          callback(DeviceListModel(
            deviceName: call.arguments['deviceName'],
            deviceAddress: call.arguments['deviceAddress'],
          ));
        }
      });
    } catch (e) {
      throw 'Error: $e';
    }
  }

  /// 监听当前的状态
  Future<void> listenState(Function(String state) callback) async {
    try {
      _channel.setMethodCallHandler((call) async {
        if (call.method == 'printerHelperState') {
          String state = call.arguments['state'];
          callback(state);
        }
      });
    } catch (e) {
      throw 'Error: $e';
    }
  }

  /// 连接打印机
  Future<void> printerHelperConnectBT(String deviceAddress) async {
    try {
      final result = await _channel.invokeMethod('printerHelperConnectBT', {'deviceAddress': deviceAddress});
      print("连接结果: $result");
    } on PlatformException catch (e) {
      print("Error: ${e.message}");
      if (e.code == "CONNECTION_FAILED") {
        print("连接失败: ${e.message}");
      } else {
        print("未知错误: ${e.message}");
      }
    }
  }
}
