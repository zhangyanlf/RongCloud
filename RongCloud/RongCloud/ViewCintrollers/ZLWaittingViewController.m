//
//  ZLWaittingViewController.m
//  RongCloud
//
//  Created by 张彦林 on 2018/8/20.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

#import "ZLWaittingViewController.h"
#import "ZLLoginController.h"
#import "ZLConversationListViewController.h"
#import <RongIMKit/RongIMKit.h>


@interface ZLWaittingViewController ()<RCIMConnectionStatusDelegate>

@property (nonatomic, assign) BOOL isShowLoginVC;

@end

@implementation ZLWaittingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:@"userToken"];
    
    if ([token length] > 0 && [[RCIM sharedRCIM] getConnectionStatus] == ConnectionStatus_Unconnected) {
        [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showConversationVC];
            });
        } error:^(RCConnectErrorCode status) {
            [self showLoginVC];
        } tokenIncorrect:^{
            [self showLoginVC];
        }];
    } else {
        _isShowLoginVC = YES;
    }
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (_isShowLoginVC) {
        _isShowLoginVC = NO;
        [self showLoginVC];
    }
}

- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    
    if (status != ConnectionStatus_Connected) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showConversationVC];
        });
    }
}

- (void)showConversationVC {
    
    ZLConversationListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ConversationVC"];
    
    vc.displayConversationTypeArray = @[@(ConversationType_PRIVATE)];
    
    [self.navigationController setViewControllers:@[vc]];
}

- (void)showLoginVC {
    [self performSegueWithIdentifier:@"ShowLoginVC" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    NSLog(@"KGLaunchSelectViewController dealloced !!");
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowLoginVC"]) {
        
        ZLLoginController *vc = segue.destinationViewController;
        [vc setRootNavigationController:self.navigationController];
    }
}


@end
