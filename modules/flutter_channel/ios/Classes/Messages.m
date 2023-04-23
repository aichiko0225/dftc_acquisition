//
//  Messages.m
//  flutter_channel
//
//  Created by 赵光飞 on 2022/1/27.
//

#import "Messages.h"

@interface CommonParams ()

+ (CommonParams *)fromMap:(NSDictionary*)dict;
- (NSDictionary *)toMap;

@end

@implementation CommonParams

+ (CommonParams*)fromMap:(NSDictionary *)dict {
    CommonParams* result = [[CommonParams alloc] init];

  result.arguments = dict[@"arguments"];
  if ((NSNull *)result.arguments == [NSNull null]) {
    result.arguments = nil;
  }
  result.key = dict[@"key"];
  if ((NSNull *)result.key == [NSNull null]) {
    result.key = nil;
  }
  return result;
}

- (NSDictionary*)toMap {
    return [NSDictionary dictionaryWithObjectsAndKeys:(self.arguments ? self.arguments : [NSNull null]), @"arguments", (self.key ? self.key : [NSNull null]), @"key", nil];
}

@end


@interface CallMethodParams ()

+ (CallMethodParams *)fromMap:(NSDictionary*)dict;
- (NSDictionary *)toMap;

@end

@implementation CallMethodParams

+ (CallMethodParams*)fromMap:(NSDictionary *)dict {
    CallMethodParams* result = [[CallMethodParams alloc] init];

  result.arguments = dict[@"arguments"];
  if ((NSNull *)result.arguments == [NSNull null]) {
    result.arguments = nil;
  }
  result.methodName = dict[@"methodName"];
  if ((NSNull *)result.methodName == [NSNull null]) {
    result.methodName = nil;
  }
  return result;
}

- (NSDictionary*)toMap {
    return [NSDictionary dictionaryWithObjectsAndKeys:(self.arguments ? self.arguments : [NSNull null]), @"arguments", (self.methodName ? self.methodName : [NSNull null]), @"methodName", nil];
}

@end


@interface ResponseParams ()

+ (ResponseParams *)fromMap:(NSDictionary*)dict;
- (NSDictionary *)toMap;

@end

@implementation ResponseParams

+ (ResponseParams*)fromMap:(NSDictionary *)dict {
    ResponseParams* result = [[ResponseParams alloc] init];

  result.arguments = dict[@"arguments"];
  if ((NSNull *)result.arguments == [NSNull null]) {
    result.arguments = nil;
  }
  result.methodName = dict[@"methodName"];
  if ((NSNull *)result.methodName == [NSNull null]) {
    result.methodName = nil;
  }
  return result;
}

- (NSDictionary*)toMap {
    return [NSDictionary dictionaryWithObjectsAndKeys:(self.arguments ? self.arguments : [NSNull null]), @"arguments", (self.methodName ? self.methodName : [NSNull null]), @"methodName", nil];
}

@end
