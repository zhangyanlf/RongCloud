//
//  ZLConversationViewController.m
//  RongCloud
//
//  Created by 张彦林 on 2018/8/20.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

#import "ZLConversationViewController.h"
#import "ZLLuckMoneyMessage.h"
#import "ZLLuckMoneyMessageCell.h"
#import "ZLRecallMessage.h"
#import "ZLRecallCell.h"
#import <RongIMLib/RongIMLib.h>
@interface ZLConversationViewController(ReceiveMessageDelegate)<RCIMReceiveMessageDelegate>

@end


@implementation ZLConversationViewController(ReceiveMessageDelegate)


- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left {
    if ([message .objectName isEqualToString:[ZLRecallMessage getObjectName]]) {
        ZLRecallMessage *rm = (ZLRecallMessage *)message.content;
        RCMessage *rcmessage = [[RCIMClient sharedRCIMClient] getMessageByUId:rm.bRecalledMessageUId];
        
        [self.conversationDataRepository enumerateObjectsUsingBlock:^(RCMessageModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (obj.messageId == rcmessage.messageId) {
                *stop = YES;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self deleteMessage:obj];
                });
            }
            
        }];
    }
}

@end

@interface ZLConversationViewController ()

@property (nonatomic, strong) RCMessageModel *longSelectModel;

@end

@implementation ZLConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"luck-money"] title:@"红包" tag:200];
    [self registerClass:[ZLLuckMoneyMessageCell class] forMessageClass:[ZLLuckMoneyMessage class]];
    [self registerClass:[ZLRecallCell class] forMessageClass:[ZLRecallMessage class]];
    
    [[RCIM sharedRCIM] setReceiveMessageDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) pluginBoardView:(RCPluginBoardView *)pluginBoardView clickedItemWithTag:(NSInteger)tag
{
    if (tag == 200) {
        //TODO: 这里点击红包弹出红包界面  以及处理红包功能
        
        [[RCIM sharedRCIM] sendMessage:self.conversationType targetId:self.targetId content:[[ZLLuckMoneyMessage alloc] initWith:200 description:@"恭喜发财"] pushContent:@"您有一条新消息" pushData:@"{\"zhangyanlf\" : 666666}" success:^(long messageId) {
            
        } error:^(RCErrorCode nErrorCode, long messageId) {
            
        }];
    } else {
        [super pluginBoardView:pluginBoardView clickedItemWithTag:tag];
    }
    
}

- (RCMessageBaseCell *)rcConversationCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RCMessageModel *m = self.conversationDataRepository[indexPath.item];
    
    if ([m.objectName isEqualToString:[ZLLuckMoneyMessage getObjectName]]) {
        ZLLuckMoneyMessageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZLLuckMoneyMessageCell identifier] forIndexPath:indexPath];
        [cell setDataModel:m];
        cell.conversationViewController = self;
        return cell;
    } else if ([m.objectName isEqualToString:[ZLRecallMessage getObjectName]]) {
        ZLRecallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZLRecallCell identifier] forIndexPath:indexPath];
        [cell setDataModel:m];
        return cell;
    } else {
        return [self rcUnkownConversationCollectionView:collectionView cellForItemAtIndexPath:indexPath];
    }
    
}

- (CGSize) rcConversationCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RCMessageModel *m = self.conversationDataRepository[indexPath.item];
    
    if ([m.objectName isEqualToString:[ZLLuckMoneyMessage getObjectName]]) {
        CGFloat h = 130 + (m.isDisplayNickname ? 20 : 0) + (m.isDisplayMessageTime ? 20 : 0);
        return CGSizeMake(collectionView.frame.size.width, h);
    } else if ([m.objectName isEqualToString:[ZLRecallMessage getObjectName]]){
        return  CGSizeMake(collectionView.frame.size.width, 40 + (m.isDisplayMessageTime ? 20 : 0));
    } else {
        return [self rcUnkownConversationCollectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
    }
}

- (void) didLongTouchMessageCell:(RCMessageModel *)model inView:(UIView *)view
{
    _longSelectModel = nil;
    [super didLongTouchMessageCell:model inView:view];
    
    UIMenuController *mvc = [UIMenuController sharedMenuController];
    UIMenuItem *recallItem = [[UIMenuItem alloc] initWithTitle:@"撤回" action:@selector(recall:)];
    
    if (mvc.menuVisible) {
        NSMutableArray *items = [NSMutableArray arrayWithArray:mvc.menuItems];
        [items addObject:recallItem];
        [mvc setMenuItems:items];
    } else {
        [mvc setMenuItems:@[recallItem]];
    }
    [mvc setMenuVisible:YES animated:YES];
    _longSelectModel = model;
}

- (void) recall:(id) sender {
 
    if (self.longSelectModel) {
        RCMessage *rm = [[RCIMClient sharedRCIMClient] getMessage:self.longSelectModel.messageId];
        [[RCIM sharedRCIM] sendMessage:self.conversationType targetId:self.targetId content: [[ZLRecallMessage alloc] initWithBeRecallUId:rm.messageUId]  pushContent:@"" pushData:@"" success:^(long messageId) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self deleteMessage:self.longSelectModel];
            });
            
        } error:^(RCErrorCode nErrorCode, long messageId) {
            
        }];
    }
    
}

@end
