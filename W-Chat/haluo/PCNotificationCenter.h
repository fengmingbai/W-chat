//
//  SNNotificationCenter.h
//  sohunews
//
//  Created by Aaron on 9/22/13.
//  Copyright 2013 talicai.com Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"


@interface PCNotificationCenter : NSObject

+ (void)showMessage:(NSString *)text;//by default 1s
+ (void)showMessage:(NSString *)text hideAfter:(NSInteger)interval;

+ (void)showLoading;
+ (void)showLoadingHideAfte:(NSInteger)interval delegate:(id<MBProgressHUDDelegate>)delegate;

+ (void)hideLoading;
+ (void)showLoading:(NSString *)msg;


+ (void)showLoadingInView:(UIView *)view;
+ (void)hideLoadingInView:(UIView *)view;

+ (void)showMessageDetail:(NSString *)text hideAfter:(NSInteger)interval;
@end
