//
//  ZLLuckMoneyMessage.m
//  RongCloud
//
//  Created by 张彦林 on 2018/8/21.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

#import "ZLLuckMoneyMessage.h"

@implementation ZLLuckMoneyMessage

 - (instancetype)initWith:(double)amount description:(NSString *)desc
{
    if ([super init]) {
        _amount = amount;
        _desc = desc;
    }
    return self;
}
// RCMessageCoding
- (NSData *)encode {
    return [NSJSONSerialization dataWithJSONObject:@{@"amount":@(_amount),@"desc":_desc} options:NSJSONWritingPrettyPrinted error:nil];
    
}

- (void)decodeWithData:(NSData *)data
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    _amount = [(NSNumber *)dic[@"amount"] doubleValue];
    _desc = (NSString *)dic[@"desc"];
}

+ (NSString *)getObjectName
{
    return NSStringFromClass([self class]);
}

//RCMessagePersistentCompatible

+ (RCMessagePersistent)persistentFlag
{
    return MessagePersistent_ISCOUNTED;
}

//RCMessageContentView

- (NSString *)conversationDigest
{
    return @"[zhangyanlf 红包]";
}

@end
