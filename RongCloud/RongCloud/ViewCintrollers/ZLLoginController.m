//
//  ZLLoginController.m
//  RongCloud
//
//  Created by 张彦林 on 2018/8/20.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

#import "ZLLoginController.h"
#import <RongIMKit/RongIMKit.h>
#import <ChameleonFramework/Chameleon.h>

@interface ZLLoginController ()
@property (weak, nonatomic) IBOutlet UIButton *zhangyanlf;

@property (weak, nonatomic) IBOutlet UIButton *luck;

@end

@implementation ZLLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _zhangyanlf.layer.borderColor = FlatPink.CGColor;
    _luck.layer.borderColor = FlatLime.CGColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)zhangyanlf:(UIButton *)sender {
    [self connectWithToken:@"IwbDUNPEfsU1Kr3n/Iqev6nnniNx73w6eLAmmTmsndYBP2+ltHkjC4nMOZFiU+fiq5QnwjY7lOXd/jL9oyTojysrhtcI8gNM" sender:sender];
}

- (IBAction)luck:(UIButton *)sender {
    [self connectWithToken:@"EZUDdYLzDkf8Gg19KpVaUnxF3nUMVwBBH0y+vQqqmafXO0vnPNnth0c+ALspnwI4zkZXbX+qLNJrHEhNKBtiVg==" sender:sender];
}

- (void) connectWithToken:(NSString *)token sender:(UIButton *)sender {
    [sender setEnabled:NO];
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [sender setEnabled:YES];
        });
        
        [self loginSuccess:token];
    } error:^(RCConnectErrorCode status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [sender setEnabled:YES];
        });
        if (status == RC_CONNECTION_EXIST) {
            [self loginSuccess:token];
        } else {
            NSLog(@"[Error] RCCONNECTIONError %ld", (long)status);
        }
    } tokenIncorrect:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [sender setEnabled:YES];
        });
        NSLog(@"[Error] tokenIncorrect");
        
    }];
    
    
}

- (void) loginSuccess:(NSString *)token{
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"userToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion: nil];
    });
}

@end
