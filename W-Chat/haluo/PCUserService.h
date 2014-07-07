//
//  PCUserService.h
//  PinChe
//
//  Created by 郭亚伦 on 10/27/13.
//  Copyright (c) 2013 Jidong Liu. All rights reserved.
//

#define kpinCheGetRegularCode_regist @"sign_up"
#define kpinCheGetRegularCode_reset @reset_pwd
#import <Foundation/Foundation.h>

typedef void(^completion)(BOOL success,id responseObject,NSError *error);
@interface PCUserService : NSObject

+ (void)loginWithUserName:(NSString *)userName passwd:(NSString *)passwd isAutoLogin:(BOOL)isAutoLogin completion:(completion) completion;
+ (void)registerWithUserName:(NSString *)userName verifyCode:(NSString *)verifyCode nickName:(NSString *)nickName passwd:(NSString *)passwd completion:(completion) completion;
+ (void)requestRegularCodeByRegister:(NSString *)userName completion:(completion) completion;
@end
