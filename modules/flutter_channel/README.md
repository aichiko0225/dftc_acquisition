# flutter_channel

封装flutter的通道插件

flutter_channel 让开发者省略了手动搭桥的功能，通过事件标识key和参数map即可完成事件传递
同样可以在调用原生方法的时候，加入回调。

## flutter端使用

 - 接收消息
```dart
///声明一个用来存回调的对象
VoidCallback removeListener;

///添加事件响应者,监听native发往flutter端的事件
removeListener = FlutterBridge.instance.addEventListener("yourEventKey", (key, arguments) {
  ///deal with your event here
  return;
});

///然后在退出的时候（比如dispose中）移除监听者
removeListener?.call();
```

 - 调用原生方法 native 来实现
```dart
// 调用原生方法
FlutterBridge.instance.callHandler('methodName', params: {}, responseCallback: (map) {
    // 设置回调
    setState(() {
        _callbackMap = Map.from(map);
    });
});
```

## iOS端使用

- Flutter调用方法原生实现

```objc
// 创建一个 Delegate 类，用于实现方法
@interface BridgeDelegate : NSObject<FlutterBridgeDelegate>
{
    int _count;
}
@end
```

```objc
@implementation BridgeDelegate

- (void)callHandler:(NSString *)methodName params:(NSDictionary *)params callback:(void (^)(id))callback {
    
    if (methodName) {
        // 根据 methodName 来处理各类原生方法
    }
    
    _count += 10;
    
    __weak typeof(self) weakSelf = self;
    // 模拟 延迟回调
    NSTimer *doNotWorkTimer =[NSTimer timerWithTimeInterval:3.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
        if (callback) {
            __strong typeof(self) strongSelf = weakSelf;
            callback(@{
                @"callback_key": @"callback_value",
                @"count": @(strongSelf->_count)
            });
        }
    }];
    [[NSRunLoop currentRunLoop] addTimer:doNotWorkTimer forMode:NSDefaultRunLoopMode];
}

@end
```

```objc
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];

    // Override point for customization after application launch.
    BridgeDelegate *delegate = [[BridgeDelegate alloc] init];
    [[FlutterBridge instance] setupDelegate:delegate];

    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
```

- 发送消息给flutter
```objc
[[FlutterBridge instance] sendEventToFlutterWith:@"key" arguments:@{@"key": @"123"}];
```

## Android端使用

- Flutter调用方法原生实现

```java
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
```

- 发送消息给flutter
```java
FlutterBridge.getInstance().sendEventToFlutter("key", new HashMap<>());
```
