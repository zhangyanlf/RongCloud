//
//  ZLLuckMoneyMessageCell.h
//  RongCloud
//
//  Created by 张彦林 on 2018/8/21.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>

@class ZLConversationViewController;

@interface ZLLuckMoneyMessageCell : RCMessageCell

@property (nonatomic,weak) ZLConversationViewController *conversationViewController;

+ (NSString *)identifier;
@end
