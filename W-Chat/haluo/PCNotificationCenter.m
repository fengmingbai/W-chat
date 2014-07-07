//
//  LCNotificationCenter.m
//  Bills
//
//  Created by Aaron on 9/22/13.
//  Copyright 2013 talicai.com Inc. All rights reserved.
//

#import "PCNotificationCenter.h"
#import "AppDelegate.h"

@implementation PCNotificationCenter

+ (void)showMessage:(NSString *)text
{
    [self showMessage:text hideAfter:1];
}


+ (void)showMessage:(NSString *)text hideAfter:(NSInteger)interval
{
    UIWindow *window = [( AppDelegate*)[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:window];
    [self showHUD:text andView:window andHUD:hud];
    hud.mode = MBProgressHUDModeText;
    hud.square = NO;
    [hud hide:YES afterDelay:interval];
}


+ (void)showLoading
{
    [self showLoading:@"正在加载"];
}

+ (void)showLoadingHideAfte:(NSInteger)interval delegate:(id<MBProgressHUDDelegate>)delegate{
	UIWindow *window = [(AppDelegate *)[UIApplication sharedApplication].delegate window];

	MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:window];
	hud.delegate = delegate;
	[self showHUD:@"正在加载" andView:window andHUD:hud];

	[hud hide:YES afterDelay:interval];

}

+ (void)showLoading:(NSString *)msg
{
    UIWindow *window = [(AppDelegate *)[UIApplication sharedApplication].delegate window];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:window];
    [self showHUD:msg andView:window andHUD:hud];
}


+ (void)hideLoading
{
    UIWindow *window = [(AppDelegate *)[UIApplication sharedApplication].delegate window];

    [MBProgressHUD hideAllHUDsForView:window animated:YES];
}

+ (void)showLoadingInView:(UIView *)view {
	MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
	[self showHUD:@"正在加载" andView:view andHUD:hud];
}

+ (void)hideLoadingInView:(UIView *)view {
	[MBProgressHUD hideAllHUDsForView:view animated:YES];
}


+ (void)showHUD:(NSString *)text andView:(UIView *)view andHUD:(MBProgressHUD *)hud
{
    [view addSubview:hud];
    hud.labelText = text;//显示提示
    hud.dimBackground = YES;//使背景成黑灰色，让MBProgressHUD成高亮显示
    hud.square = YES;//设置显示框的高度和宽度一样
    [hud show:YES];
}

+ (void)showMessageDetail:(NSString *)text hideAfter:(NSInteger)interval
{
    UIWindow *window = [(AppDelegate *)[UIApplication sharedApplication].delegate window];

	MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:window];
	[self showHUDDetail:text andView:window andHUD:hud];
	hud.mode = MBProgressHUDModeText;
	hud.square = NO;
	[hud hide:YES afterDelay:interval];
}

+ (void)showHUDDetail:(NSString *)text andView:(UIView *)view andHUD:(MBProgressHUD *)hud{
	[view addSubview:hud];
	hud.detailsLabelText = text;//显示提示
	hud.dimBackground = YES;//使背景成黑灰色，让MBProgressHUD成高亮显示
	hud.square = YES;//设置显示框的高度和宽度一样
	[hud show:YES];
}


@end
