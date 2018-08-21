//
//  ZLUserDataSource.m
//  RongCloud
//
//  Created by 张彦林 on 2018/8/20.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

#import "ZLUserDataSource.h"
@interface ZLUserDataSource()

@property (nonatomic,strong) RCUserInfo *zhangyanlf;
@property (nonatomic,strong) RCUserInfo *luckyboy;

@end

@implementation ZLUserDataSource


- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion {
    if ([[userId lowercaseString] isEqualToString:@"zhangyanlf"]) {
        completion(self.zhangyanlf);
    } else {
        completion(self.luckyboy);
    }
    
}

- (RCUserInfo *)zhangyanlf {
    if (!_zhangyanlf) {
        _zhangyanlf = [[RCUserInfo alloc] initWithUserId:@"zhangyanlf" name:@"张彦林" portrait:@"http://touxiang.qqzhi.com/uploads/2012-11/1111104151660.jpg"];
    }
    return _zhangyanlf;
}


- (RCUserInfo *)luckyboy {
    if (!_luckyboy) {
        _luckyboy = [[RCUserInfo alloc] initWithUserId:@"luck" name:@"幸运男孩" portrait:@"http://touxiang.qqzhi.com/uploads/2012-11/1111014928675.jpg"];
    }
    return _luckyboy;
}

@end
