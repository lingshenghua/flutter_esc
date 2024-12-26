package com.kq.flutter_esc;

import android.app.Application;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.util.Log;

import androidx.core.app.ActivityCompat;

import com.prt.esc.PrinterHelper;
import com.prt.esc.printer.Printer;

import java.util.HashMap;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;


public class EscPlugin extends Application {

    private BluetoothAdapter mBluetoothAdapter;
    private Context context;

    private MethodChannel methodChannel;

    // 初始化
    public void printerHelperInit(Context context) {
        this.context = context;
        PrinterHelper.init(this);
    }

    // 注册蓝牙广播
    public void registerBroadcast(Context context, BinaryMessenger messenger) {
        this.context = context;
        this.methodChannel = new MethodChannel(messenger, "com.kq.flutter_esc/plugin");
        // 获取蓝牙适配器
        mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        if (mBluetoothAdapter == null) {
            Log.e("ESC", "设备不支持蓝牙");
            return;
        }
        // 注册蓝牙广播
        registerBluetoothReceiver(context);
        startBluetoothDiscovery();
    }

    // 注册蓝牙接收器
    private void registerBluetoothReceiver(Context context) {
        IntentFilter filter = new IntentFilter();
        filter.addAction(BluetoothDevice.ACTION_FOUND);
        filter.addAction(BluetoothAdapter.ACTION_DISCOVERY_FINISHED);
        context.registerReceiver(bluetoothReceiver, filter);
        Log.e("ESC", "蓝牙广播已注册");
        HashMap<String, String> stateInfo = new HashMap<>();
        stateInfo.put("state", "蓝牙广播已注册");
        methodChannel.invokeMethod("printerHelperState", stateInfo);
    }

    // 启动蓝牙设备扫描
    private void startBluetoothDiscovery() {
        if (!mBluetoothAdapter.isEnabled()) {
            if (ActivityCompat.checkSelfPermission(context, android.Manifest.permission.BLUETOOTH_CONNECT) != PackageManager.PERMISSION_GRANTED) {
                Log.e("ESC", "蓝牙权限没有获取1");
                return;
            }
            mBluetoothAdapter.enable();
        }
        mBluetoothAdapter.startDiscovery();
    }

    // 蓝牙广播接收器
    private final BroadcastReceiver bluetoothReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if (BluetoothDevice.ACTION_FOUND.equals(action)) {
                BluetoothDevice device = intent.getParcelableExtra(BluetoothDevice.EXTRA_DEVICE);
                if (device != null) {
                    if (ActivityCompat.checkSelfPermission(context, android.Manifest.permission.BLUETOOTH_CONNECT) != PackageManager.PERMISSION_GRANTED) {
                        Log.e("ESC", "蓝牙权限没有获取2");
                        return;
                    }

                    //代表是经典蓝⽛协议的打印机
                    if (device.getBluetoothClass().getMajorDeviceClass() == 1536) {
                        //获取设备名称和地址
                        String deviceName = device.getName();
                        String deviceAddress = device.getAddress();
                        HashMap<String, String> deviceInfo = new HashMap<>();
                        deviceInfo.put("deviceName", deviceName);
                        deviceInfo.put("deviceAddress", deviceAddress);
                        methodChannel.invokeMethod("forBluetoothDevices", deviceInfo);
                    }
                }
            } else if (BluetoothAdapter.ACTION_DISCOVERY_FINISHED.equals(action)) {
                Log.e("ESC", "蓝牙扫描完成");
                HashMap<String, String> stateInfo = new HashMap<>();
                stateInfo.put("state", "蓝牙扫描完成");
                methodChannel.invokeMethod("printerHelperState", stateInfo);
            }
        }
    };


    // 连接打印机
    public void printerHelperConnectBT(String btMac, MethodChannel.Result result) {
        Printer printer = PrinterHelper.connectBT(btMac);
        if (printer == null) {
            HashMap<String, String> stateInfo = new HashMap<>();
            stateInfo.put("state", "连接失败");
            methodChannel.invokeMethod("printerHelperState", stateInfo);
            Log.e("ESC", "连接失败");
            result.error("CONNECTION_FAILED", "连接打印机失败: " + btMac, null);
        } else {
            //连接成功，所有打印相关的接⼝都在Printer类⾥⾯
            HashMap<String, String> stateInfo = new HashMap<>();
            stateInfo.put("state", "连接成功");
            methodChannel.invokeMethod("printerHelperState", stateInfo);
            Log.e("ESC", "连接成功");
            result.success("连接成功: " + btMac);
        }
    }


}
