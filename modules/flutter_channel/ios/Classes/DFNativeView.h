//
//  DFNativeView.h
//  flutter_dynamic_platform_view
//
//  Created by 赵光飞 on 2022/2/18.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFNativeView : NSObject<FlutterPlatformView>

- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger;

@end

NS_ASSUME_NONNULL_END
