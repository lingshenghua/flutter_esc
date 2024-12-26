package com.kq.flutter_esc;

import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.kq.flutter_esc/plugin";

    private EscPlugin escPlugin;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // 初始化 EscPlugin 插件
        escPlugin = new EscPlugin();
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        // 设置通道方法处理
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    switch (call.method) {
                        // 初始化
                        case "printerHelperInit":
                            Log.e("ESC", "escInit");
                            escPlugin.printerHelperInit(this);
                            break;
                        // 注册蓝牙广播
                        case "registerBroadcast":
                            Log.e("ESC", "registerBroadcast");
                            escPlugin.registerBroadcast(this, flutterEngine.getDartExecutor().getBinaryMessenger());
                            break;
                        // 连接打印机
                        case "printerHelperConnectBT":
                            Log.e("ESC", "printerHelperConnectBT");
                            String deviceAddress = call.argument("deviceAddress");
                            escPlugin.printerHelperConnectBT(deviceAddress,result);
                            break;
                        default:
                            result.notImplemented();
                            break;
                    }
                });
    }
}
