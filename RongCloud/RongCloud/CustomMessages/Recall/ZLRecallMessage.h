//
//  ZLRecallMessage.h
//  RongCloud
//
//  Created by 张彦林 on 2018/8/21.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>

@interface ZLRecallMessage : RCMessageContent

@property (nonatomic, strong) NSString *bRecalledMessageUId;

- (instancetype) initWithBeRecallUId:(NSString *)uid;

@end
