package com.example.flutter_channel_example;

import android.os.Bundle;
import android.os.PersistableBundle;
import android.view.MotionEvent;

import com.example.flutter_channel.FlutterBridge;
import com.example.flutter_channel.FlutterBridgeDelegate;

import java.util.HashMap;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import androidx.annotation.Nullable;
import io.flutter.Log;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.BasicMessageChannel;

public class MainActivity extends FlutterActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        FlutterBridge.getInstance().setupDelegate(new FlutterBridgeDelegate() {
            @Override
            public void callHandler(String methodName, Map<String, Object> params, @Nullable BasicMessageChannel.Reply<Map<String, Object>> callback) {
                if (callback != null) {
                    TimerTask task = new TimerTask() {
                        @Override
                        public void run() {
                            HashMap<String, Object> map = new HashMap<>();
                            map.put("callback_key", "key1");
                            map.put("callback_value", "value111");
                            callback.reply(map);
                        }
                    };
                    Timer timer = new Timer();
                    timer.schedule(task, 3000);
                }
            }
        });

        TimerTask task = new TimerTask() {
            @Override
            public void run() {
                FlutterBridge.getInstance().sendEventToFlutter("key", new HashMap<>());
            }
        };
        Timer timer = new Timer();
        timer.schedule(task, 10000);
    }
}
