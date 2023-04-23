package com.example.flutter_channel;

import android.os.Handler;
import android.os.Looper;

import java.util.HashMap;
import java.util.Map;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.StandardMessageCodec;


public class FlutterBridge implements BasicMessageChannel.MessageHandler<Map<String, Object>> {

   class MainThreadRunnable {

      private Runnable runnable;
      private Handler handler;

      MainThreadRunnable(Runnable runnable) {
         this.runnable = runnable;
         handler = new Handler(Looper.getMainLooper());

         handler.post(this.runnable);
      }
   }

   //静态内部类
   private static class FlutterBridgeHolder {
      private static final FlutterBridge sInstance = new FlutterBridge();
   }

   private FlutterBridge() {
   }

   public static FlutterBridge getInstance() {
      //第一次调用getInstance方法时才加载FlutterBridgeHolder并初始化sInstance
      return FlutterBridgeHolder.sInstance;
   }

   private BinaryMessenger binaryMessenger;

   private FlutterBridgeDelegate _delegate;

   private BasicMessageChannel _nativeChannel;

   public static void setupFlutterBinaryMessenger(BinaryMessenger messenager) {
      FlutterBridge.getInstance().binaryMessenger = messenager;
      FlutterBridge.getInstance().setNativeMessageHandler();
   }

   /// 利用自定义配置进行初始化
   /// @param delegate FlutterBridgeDelegate的实例，用于实现methodName 的处理方法
   public void setupDelegate(FlutterBridgeDelegate delegate) {
      this._delegate = delegate;
   }

   void setNativeMessageHandler() {
      if (_nativeChannel == null) {
         _nativeChannel = new BasicMessageChannel<>(this.binaryMessenger, "flutter.sendEvent.native", new StandardMessageCodec());

         _nativeChannel.setMessageHandler(this);
      }
   }

   @Override
   public void onMessage(@Nullable Map<String, Object> message, @NonNull BasicMessageChannel.Reply<Map<String, Object>> reply) {
      if (message != null) {

         if (_delegate == null) {
            reply.reply(_getErrorMap(-3));
            return;
         }

         CallMethodParams params = CallMethodParams.fromMap(message);

         if (params.getMethodName() == null || params.getMethodName().length() == 0) {
            reply.reply(_getErrorMap(-2));
            return;
         }

         String methodName = params.getMethodName();

         _delegate.callHandler(methodName, params.getArguments(), (value) -> {
            if (value != null) {
               sendCallbackToFlutter(methodName, value);
            }
         });
         reply.reply(new HashMap<>());
         return;
      }
      reply.reply(_getErrorMap(-1));
   }


   Map<String, Object> _getErrorMap(int code) {
      HashMap<String, String> map = new HashMap<>();

      if (code == -1) {
         map.put("code", "-1001");
         map.put("message", "message 格式不正确");
         map.put("details", "message 格式不正确!!!");
      } else if (code == -2) {
         map.put("code", "-1002");
         map.put("message", "methodName 不可为空");
         map.put("details", "methodName 不可为空!!!");
      } else if (code == -3) {
         map.put("code", "-1003");
         map.put("message", "delegate 未设置");
         map.put("details", "delegate 未设置，请使用setupDelegate初始化代理方法");
      }

      HashMap<String, Object> _t_map = new HashMap<>();
      _t_map.put("error", map);
      return _t_map;
   }

   /// 将自定义事件传递给flutter侧
   /// @param key 事件的标识符
   /// @param arguments 事件的参数
   public void sendEventToFlutter(String key, Map<String, Object> arguments) {
      CommonParams params = new CommonParams(key);
      params.arguments = arguments;

      BasicMessageChannel channel = new BasicMessageChannel<>(binaryMessenger, "flutter.sendEvent.listener", new StandardMessageCodec());

      new MainThreadRunnable(() -> {
         channel.send(params.toMap(), (reply) -> {

         });
      });
   }

   /// 将自定义事件传递给flutter侧
   /// @param methodName 调用原生端的方法名称
   /// @param arguments 事件的参数
   public void sendCallbackToFlutter(String methodName, Map<String, Object> arguments) {
      ResponseParams params = new ResponseParams(methodName);
      params.arguments = arguments;

      new MainThreadRunnable(() -> {
         _nativeChannel.send(params.toMap(), (reply) -> {

         });
      });
   }

}
