//
//  Messages.h
//  flutter_channel
//
//  Created by 赵光飞 on 2022/1/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 事件订阅的model
@interface CommonParams : NSObject

@property(nonatomic, strong, nullable) NSDictionary *arguments;
@property(nonatomic, copy, nullable) NSString *key;

- (NSDictionary *)toMap;

@end

/// 调用方法的参数 与ResponseParams 分开
@interface CallMethodParams : NSObject

@property(nonatomic, strong, nullable) NSDictionary *arguments;
@property(nonatomic, copy, nullable) NSString *methodName;

- (NSDictionary *)toMap;
+ (CallMethodParams *)fromMap:(NSDictionary*)dict;

@end

/// 调用方法回调的model
@interface ResponseParams : NSObject

@property(nonatomic, strong, nullable) NSDictionary *arguments;
@property(nonatomic, copy, nullable) NSString *methodName;


- (NSDictionary *)toMap;

@end

NS_ASSUME_NONNULL_END
