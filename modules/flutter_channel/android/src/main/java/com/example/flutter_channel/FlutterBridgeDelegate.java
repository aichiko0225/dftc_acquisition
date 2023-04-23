package com.example.flutter_channel;

import java.util.Map;

import androidx.annotation.Nullable;
import io.flutter.plugin.common.BasicMessageChannel;

public interface FlutterBridgeDelegate {

    void callHandler(String methodName, Map<String, Object> params, @Nullable final BasicMessageChannel.Reply<Map<String, Object>> callback);
}
