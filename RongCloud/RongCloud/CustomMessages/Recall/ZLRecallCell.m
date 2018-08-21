//
//  ZLRecallCell.m
//  RongCloud
//
//  Created by 张彦林 on 2018/8/21.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

#import "ZLRecallCell.h"
#import <Masonry/Masonry.h>

@interface ZLRecallCell()

@property (nonatomic,strong) RCTipLabel *tipLabel;

@end

@implementation ZLRecallCell

 + (NSString *)identifier
{
    return NSStringFromClass([self class]);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void) commonInit {
    RCTipLabel *tipLabel = [RCTipLabel greyTipLabel];
    [self.baseContentView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.equalTo(self.baseContentView.mas_centerX);
    }];
    _tipLabel = tipLabel;
}

- (void)setModel:(RCMessageModel *)model
{
    [super setModel:model];
    //获取具体的名字
    if(model.messageDirection == MessageDirection_SEND){
        self.tipLabel.text = @"你撤回了一条消息";
    } else {
        self.tipLabel.text = @"ta撤回了一条消息";
    }
}

@end
