//
//  DFNativeViewFactory.m
//  flutter_dynamic_platform_view
//
//  Created by 赵光飞 on 2022/2/18.
//

#import "DFNativeViewFactory.h"
#import "DFNativeView.h"

@implementation DFNativeViewFactory
{
    NSObject<FlutterBinaryMessenger>* _messenger;
}

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger> *)messenger {
    self = [super init];
    if (self) {
        _messenger = messenger;
    }
    return self;
}

/**
 * 返回platformview实现类
 *@param frame 视图的大小
 *@param viewId 视图的唯一表示id
 *@param args 从flutter  creationParams 传回的参数
 *
 */
- (NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame
                                    viewIdentifier:(int64_t)viewId
                                         arguments:(id _Nullable)args {
    return [[DFNativeView alloc] initWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messenger];
}

// 如果需要使用args传参到ios，需要实现这个方法，返回协议。否则会失败。
- (NSObject<FlutterMessageCodec>*)createArgsCodec {
    return [FlutterStandardMessageCodec sharedInstance];
}

@end
