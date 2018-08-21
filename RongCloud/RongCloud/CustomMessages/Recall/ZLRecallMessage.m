//
//  ZLRecallMessage.m
//  RongCloud
//
//  Created by 张彦林 on 2018/8/21.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

#import "ZLRecallMessage.h"

@implementation ZLRecallMessage

- (instancetype)initWithBeRecallUId:(NSString *)uid
{
    self = [super init];
    if (self) {
        _bRecalledMessageUId = uid;
    }
    return self;
}


// RCMessageCoding
- (NSData *)encode {
    return [NSJSONSerialization dataWithJSONObject:@{@"uid":_bRecalledMessageUId} options:NSJSONWritingPrettyPrinted error:nil];
    
}

- (void)decodeWithData:(NSData *)data
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    _bRecalledMessageUId = (NSString *)dic[@"uid"];
}

+ (NSString *)getObjectName
{
    return NSStringFromClass([self class]);
}

//RCMessagePersistentCompatible

+ (RCMessagePersistent)persistentFlag
{
    return MessagePersistent_ISPERSISTED;
}

//RCMessageContentView

- (NSString *)conversationDigest
{
    return @"[撤回消息]";
}



@end
