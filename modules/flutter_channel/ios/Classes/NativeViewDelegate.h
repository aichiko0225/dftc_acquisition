//
//  NativeViewDelegate.h
//  Pods
//
//  Created by 赵光飞 on 2022/2/19.
//
#import <UIKit/UIKit.h>

@protocol NativeViewDelegate <NSObject>

@required
- (UIView *)nativeSubview:(UIView *)superView params:(NSDictionary *)params;

@end
