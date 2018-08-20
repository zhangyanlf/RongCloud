//
//  ZLConversationListViewController.m
//  RongCloud
//
//  Created by 张彦林 on 2018/8/20.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

#import "ZLConversationListViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "ZLConversationViewController.h"

@interface ZLConversationListViewController ()

@end

@implementation ZLConversationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.conversationListTableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//退出按钮
- (IBAction)logout:(UIBarButtonItem *)sender {
    [[RCIM sharedRCIM] logout];
    //移除token
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WaittingVC"];
    [self.navigationController setViewControllers:@[vc] animated:YES];
    
}

- (IBAction)addBtnItem:(UIBarButtonItem *)sender {
    NSString *targetId = @"luckyboy";
    if ([[[RCIMClient sharedRCIMClient] currentUserInfo].userId isEqualToString:targetId]) {
        targetId = @"zhangyanlf";
    }
    
    ZLConversationViewController *vc = [[ZLConversationViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:targetId];
    vc.title = targetId;
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end
