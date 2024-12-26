import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  static final PermissionManager _instance = PermissionManager._internal();

  factory PermissionManager() => _instance;

  PermissionManager._internal();

  /// 请求单个权限
  Future<bool> requestPermission(Permission permission) async {
    final status = await permission.request();
    return status.isGranted;
  }

  /// 请求多个权限
  Future<Map<Permission, PermissionStatus>> requestPermissions(
      List<Permission> permissions) async {
    return await permissions.request();
  }

  /// 检查单个权限状态
  Future<bool> isPermissionGranted(Permission permission) async {
    return await permission.isGranted;
  }

  /// 检查多个权限状态
  Future<Map<Permission, bool>> checkPermissions(
      List<Permission> permissions) async {
    Map<Permission, bool> results = {};
    for (var permission in permissions) {
      results[permission] = await permission.isGranted;
    }
    return results;
  }

  /// 引导用户到设置页面
  Future<void> openSettings() async {
    await openAppSettings();
  }
}
