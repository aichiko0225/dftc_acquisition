//
//  FlutterBridge.m
//  flutter_channel
//
//  Created by 赵光飞 on 2022/1/27.
//

#import "FlutterBridge.h"
#import <Flutter/Flutter.h>
#import "Messages.h"
#import "FlutterBridgeDelegate.h"
#import "NativeViewDelegate.h"

@interface FlutterBridge ()

@property (nonatomic, strong) NSObject<FlutterBinaryMessenger> *binaryMessenger;

@property (nonatomic, strong) id<FlutterBridgeDelegate> delegate;

@property (nonatomic, strong, readwrite) id<NativeViewDelegate> viewDelegate;

@property (nonatomic, strong) FlutterBasicMessageChannel *nativeChannel;

@end

@implementation FlutterBridge

+ (instancetype)instance{
    static id _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [self.class new];
    });
    
    return _instance;
}

+ (void)setupFlutterBinaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenager {
    [FlutterBridge instance].binaryMessenger = messenager;
    [[FlutterBridge instance] setNativeMessageHandler];
}

- (void)setupDelegate:(id<FlutterBridgeDelegate>)delegate {
    _delegate = delegate;
}

- (void)setupViewDelegate:(id<NativeViewDelegate>)viewDelegate {
    _viewDelegate = viewDelegate;
}

- (void)sendEventToFlutterWith:(NSString *)key arguments:(NSDictionary *)arguments {
    [self sendEventToFlutterWith:key arguments:arguments completion:^(NSError * _Nullable error) {
        
    }];
}

- (void)sendEventToFlutterWith:(NSString *)key arguments:(NSDictionary *)arguments  completion:(void(^)(NSError* _Nullable))completion {
    CommonParams* params = [[CommonParams alloc] init];
    params.key = key;
    params.arguments = arguments;
    
    FlutterBasicMessageChannel *channel =
        [FlutterBasicMessageChannel
          messageChannelWithName:@"flutter.sendEvent.listener"
          binaryMessenger:self.binaryMessenger];
    [channel sendMessage:[params toMap] reply:^(id  _Nullable reply) {
        completion(nil);
    }];
}

- (void)setNativeMessageHandler {
    if (!_nativeChannel) {
        _nativeChannel =
            [FlutterBasicMessageChannel
              messageChannelWithName:@"flutter.sendEvent.native"
              binaryMessenger:self.binaryMessenger];
        
        __weak typeof(self) weakSelf = self;
        
        [_nativeChannel setMessageHandler:^(id _Nullable message, FlutterReply _Nonnull callback) {
            NSDictionary *dic = message;
            
            if (dic != nil) {
                
                __strong typeof(self) strongSelf = weakSelf;
                
                if (strongSelf.delegate == nil) {
                    callback(@{
                        @"error": @{
                            @"code": @"-1003",
                            @"message": @"delegate 未设置",
                            @"details": @"delegate 未设置，请使用setupDelegate初始化代理方法"
                        }
                    });
                    return;
                }
                
                CallMethodParams *params = [CallMethodParams fromMap:dic];
                
                if (params.methodName == nil || params.methodName.length == 0) {
                    callback(@{
                        @"error": @{
                            @"code": @"-1002",
                            @"message": @"methodName 不可为空",
                            @"details": @"methodName 不可为空!!!"
                        }
                    });
                    return;
                }
                
                NSString *methodName = params.methodName;
                
                if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(callHandler:params:callback:)]) {
                    
                    [strongSelf.delegate callHandler:methodName params:params.arguments callback:^(id value) {
                        if ([value isKindOfClass:[NSDictionary class]]) {
                            [strongSelf sendCallbackToFlutter:methodName arguments:value];
                        } else {
                            // value的格式不正确
                        }
                    }];
                }
                
                callback(@{});
            }
            
            callback(@{
                @"error": @{
                    @"code": @"-1001",
                    @"message": @"message 格式不正确",
                    @"details": @"message 格式不正确!!!"
                }
            });
        }];
    }
}

- (void)sendCallbackToFlutter:(NSString *)methodName arguments:(NSDictionary*)arguments {
    ResponseParams* params = [[ResponseParams alloc] init];
    params.methodName = methodName;
    params.arguments = arguments;
    
    [self.nativeChannel sendMessage:[params toMap] reply:^(id  _Nullable reply) {
        
    }];
}

@end
