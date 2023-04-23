#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import <flutter_channel/FlutterBridgeDelegate.h>
#import <flutter_channel/FlutterBridge.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface BridgeDelegate : NSObject<FlutterBridgeDelegate>
{
    int _count;
}

@end

@implementation BridgeDelegate

- (void)callHandler:(NSString *)methodName params:(NSDictionary *)params callback:(void (^)(id))callback {
    
    if (methodName) {
        // 根据 methodName 来处理各类原生方法
    }
    
    _count += 10;
    
    __weak typeof(self) weakSelf = self;
    // 创建 NSTimer
    NSTimer *doNotWorkTimer =[NSTimer timerWithTimeInterval:3.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
        if (callback) {
            __strong typeof(self) strongSelf = weakSelf;
            callback(@{
                @"callback_key": @"123",
                @"count": @(strongSelf->_count)
            });
        }
    }];
    // NSTimer 加入 NSRunLoop
    [[NSRunLoop currentRunLoop] addTimer:doNotWorkTimer forMode:NSDefaultRunLoopMode];
}

@end

@interface AppDelegate ()<NativeViewDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
    // Override point for customization after application launch.

//    [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(delayMethod) userInfo:nil repeats:YES];

    BridgeDelegate *delegate = [[BridgeDelegate alloc] init];
    [[FlutterBridge instance] setupDelegate:delegate];

    [[FlutterBridge instance] setupViewDelegate: self];
    
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}


- (void)delayMethod {
    [[FlutterBridge instance] sendEventToFlutterWith:@"key" arguments:@{@"key": @"123"}];
    UIView *view = self.window.rootViewController.view;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"SendEventToFlutter";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
    });
}

- (UIView *)nativeSubview:(UIView *)superView params:(NSDictionary *)params {
    
    NSArray *childrens = params[@"children"];
    
    for (NSDictionary *dic in childrens) {
        NSString *unitName = dic[@"unitName"];
        NSString *value = dic[@"value"];
        
        if ([unitName isEqualToString:@"text"]) {
            UILabel *label = [[UILabel alloc] init];
            label.text = value;
            [superView addSubview:label];
            label.frame = CGRectMake(0, 0, 100, 20);
        }
    }
    
    return nil;
}

@end
