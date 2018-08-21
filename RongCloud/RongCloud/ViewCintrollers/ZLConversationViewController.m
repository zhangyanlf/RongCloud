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

@interface ZLConversationViewController ()

@end

@implementation ZLConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"luck-money"] title:@"红包" tag:200];
    [self registerClass:[ZLLuckMoneyMessageCell class] forMessageClass:[ZLLuckMoneyMessage class]];
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
    } else {
        return [self rcUnkownConversationCollectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
    }
}

@end
