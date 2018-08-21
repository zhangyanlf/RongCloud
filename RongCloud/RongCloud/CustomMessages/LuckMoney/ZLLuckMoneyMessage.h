//
//  ZLLuckMoneyMessage.h
//  RongCloud
//
//  Created by 张彦林 on 2018/8/21.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>

@interface ZLLuckMoneyMessage : RCMessageContent

@property (nonatomic,assign) double amount;
@property (nonatomic,strong) NSString *desc;

- (instancetype) initWith:(double)amount description:(NSString *)desc;

@end
