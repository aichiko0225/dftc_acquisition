//
//  DFNativeViewFactory.h
//  flutter_dynamic_platform_view
//
//  Created by 赵光飞 on 2022/2/18.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFNativeViewFactory : NSObject<FlutterPlatformViewFactory>

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;

@end

NS_ASSUME_NONNULL_END
