//
//  DFNativeView.m
//  flutter_dynamic_platform_view
//
//  Created by 赵光飞 on 2022/2/18.
//

#import "DFNativeView.h"
#import "FlutterBridge.h"
#import "NativeViewDelegate.h"

@implementation DFNativeView
{
    UIView *_view;
    NSObject<FlutterBinaryMessenger>* _messenger;
}

- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger {
    self = [super init];
    if (self) {
        _messenger = messenger;
        _view = [[UIView alloc] initWithFrame:frame];
        _view.backgroundColor = [UIColor redColor];
        
#ifdef DEBUG
        NSLog(@"frame: %@", NSStringFromCGRect(frame));
        NSLog(@"viewId: %lld", viewId);
        NSLog(@"args: %@", args);
#endif
        if (args) {
            NSDictionary *params = (NSDictionary *)args;
            
            // 原生视图的类型，如果不是指定的类型中的几个，则默认为view
            // 暂时提供几个快捷的UIView样式
            NSString *viewName = params[@"viewName"];
            
            // view 下面的子视图，只支持单层结构
            NSString *jsonString = params[@"jsonObject"];
            NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error;
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingFragmentsAllowed error:&error];
            if(error) {
                NSLog(@"json解析失败：%@", error);
                return nil;
            }
            
            [self updateContainerView:jsonObject];

        }
    }
    return self;
}

/*
 {
    "container": {
        "unitName": "Container",
        "children": [
        ]
    }
 }
 
 */


- (void)updateContainerView:(NSDictionary *)jsonObject {
    if (!jsonObject) {
        return;
    }
    
    NSDictionary *container_dic = jsonObject[@"container"];
    
    if ([FlutterBridge instance].viewDelegate) {
        id<NativeViewDelegate> delegate = [FlutterBridge instance].viewDelegate;
        if (delegate && [delegate respondsToSelector:@selector(nativeSubview:params:)]) {
            
            UIView *view = [delegate nativeSubview:_view params:container_dic];
            if (view) {
                if ([_view.subviews containsObject:view]) {
                    [_view addSubview:view];
                    view.frame = _view.bounds;
                }
            }
            return;
        }
    }
    
    NSParameterAssert([FlutterBridge instance].viewDelegate != nil);
    
    NSArray *childrens = container_dic[@"children"];
    
    for (NSDictionary *dic in childrens) {
        NSString *unitName = dic[@"unitName"];
        NSString *value = dic[@"value"];
        
        if ([unitName isEqualToString:@"text"]) {
            UILabel *label = [[UILabel alloc] init];
            label.text = value;
            [_view addSubview:label];
            label.frame = CGRectMake(0, 0, 100, 20);
        }
    }
}

- (UIView *)view {
    return _view;
}

@end
