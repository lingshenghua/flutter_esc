import 'package:flutter/material.dart';
import 'package:flutter_esc/pages/main/main_controller.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() => MainController.to.isBluetoothGranted.isTrue
                ? ElevatedButton(onPressed: MainController.to.registerBroadcast, child: const Text('获取打印机列表'))
                : ElevatedButton(
                    onPressed: MainController.to.requestBluetoothPermissions, child: const Text('获取蓝牙权限'))),
            const SizedBox(
              height: 30,
            ),
            Expanded(
                child: Obx(() => MainController.to.deviceList.isEmpty
                    ? const SizedBox.shrink()
                    : ListView.builder(
                        itemCount: MainController.to.deviceList.length,
                        itemBuilder: (context, index) {
                          final device = MainController.to.deviceList[index];
                          return ListTile(
                            title: Text(device.deviceName),
                            subtitle: Text(device.deviceAddress),
                            trailing: ElevatedButton(
                              child: const Text('连接'),
                              onPressed: () => MainController.to.printerHelperConnectBT(device.deviceAddress),
                            ),
                          );
                        },
                      ))),
          ],
        ),
      ),
    );
  }
}
