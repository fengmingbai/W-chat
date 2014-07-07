//
//  FFRegisterViewController.m
//  W-Chat
//
//  Created by 冯明白 on 14-7-2.
//  Copyright (c) 2014年 HL. All rights reserved.
//

#import "FFRegisterViewController.h"
#import "PCUserService.h"
#import "FFXPManager.h"

@interface FFRegisterViewController ()

@end

@implementation FFRegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)initSubView
{
    self.password.secureTextEntry = YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)regiserSend:(id)sender {
    if (!self.loginName || !self.password || self.loginName.text.length == 0 || self.password.text.length == 0 ) {
        [FFFactory showAlertViewWithMessage:@"用户名或密码不能为空"];
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:self.loginName.text forKey:USER_NAME];
    [[NSUserDefaults standardUserDefaults] setObject:self.password.text forKey:USER_PASSWORD];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[FFXPManager defaultManager] registerNewUserWithBlock:^(BOOL success, id responseObject, NSError *error) {
        if (success) {
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:USER_AUTOLOGIN];
            [[NSUserDefaults standardUserDefaults] synchronize];

            [APP_DELEGATE showLoginPage];
        }
        else
        {
            
        }
    }];
}

- (IBAction)backLogin:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
