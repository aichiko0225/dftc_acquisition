//
//  FlutterBrigdeDelegate.h
//  Pods
//
//  Created by 赵光飞 on 2022/1/28.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

@protocol FlutterBridgeDelegate <NSObject>

@required
- (void)callHandler:(NSString *)methodName
             params:(NSDictionary *)params
           callback:(void(^)(id))callback;

@end
