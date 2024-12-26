import 'package:flutter_esc/common/permission_manager.dart';
import 'package:flutter_esc/model/device_list_model.dart';
import 'package:flutter_esc/plugin/esc_plugin.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class MainController extends GetxController {
  static MainController get to => Get.find();
  final EscPlugin escPlugin = EscPlugin();
  final PermissionManager permissionManager = PermissionManager();

  /// 设备列表
  RxList<DeviceListModel> deviceList = <DeviceListModel>[].obs;

  /// 监听权限状态
  RxBool isBluetoothGranted = false.obs;

  /// 获取权限
  Future<void> requestBluetoothPermissions() async {
    /// 请求多个权限
    Map<Permission, PermissionStatus> statuses = await permissionManager.requestPermissions([
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
    ]);

    /// 检查权限请求结果
    if (statuses[Permission.bluetooth]?.isGranted == true &&
        statuses[Permission.bluetoothScan]?.isGranted == true &&
        statuses[Permission.bluetoothConnect]?.isGranted == true &&
        statuses[Permission.location]?.isGranted == true) {
      /// 所有权限都被授予
      isBluetoothGranted.value = true;
      Get.showSnackbar(const GetSnackBar(
        title: "权限通知",
        message: "蓝牙权限全部启用",
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      ));
      escPlugin.printerHelperInit();
      escPlugin.listenForBluetoothDevices((DeviceListModel deviceListModel) {
        deviceList.add(deviceListModel);
      });
      escPlugin.listenState((String state) {
        Get.showSnackbar(GetSnackBar(
          title: "当前运行状态",
          message: state,
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
        ));
      });
    } else {
      Get.showSnackbar(const GetSnackBar(
        title: "权限通知",
        message: "蓝牙权限未全部启用",
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      ));
    }
  }

  /// 注册蓝⽛⼴播
  void registerBroadcast() {
    if (!isBluetoothGranted.value) {
      Get.showSnackbar(const GetSnackBar(
        title: "权限通知",
        message: "蓝牙权限未全部启用",
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      ));
      return;
    }
    escPlugin.registerBroadcast();
  }

  /// 连接设备
  void printerHelperConnectBT(String deviceAddress) {
    escPlugin.printerHelperConnectBT(deviceAddress);
  }

  /// 初始化方法
  @override
  void onInit() {
    requestBluetoothPermissions();
    super.onInit();
  }

  /// 当控制器被释放时调用的方法
  @override
  void onClose() {
    super.onClose();
  }
}
