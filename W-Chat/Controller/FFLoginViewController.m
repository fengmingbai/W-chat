//
//  FFLoginViewController.m
//  W-Chat
//
//  Created by 冯明白 on 14-7-2.
//  Copyright (c) 2014年 HL. All rights reserved.
//

#import "FFLoginViewController.h"
#import "FFRegisterViewController.h"
#import "FFXPManager.h"
#import "PCNotificationCenter.h"

@interface FFLoginViewController ()

@end

@implementation FFLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if ([[NSUserDefaults standardUserDefaults] boolForKey:USER_AUTOLOGIN]) {
        if (!self.noAutoLogin) [self loginIn];
    }
}

- (void)initSubView
{
    [self.autoLoginButton setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    self.autoLoginButton.selected = [[NSUserDefaults standardUserDefaults] boolForKey:USER_AUTOLOGIN];
    
    self.passwordField.secureTextEntry = YES;
    self.passwordField.clearButtonMode =UITextFieldViewModeAlways;
    self.nameField.clearButtonMode = UITextFieldViewModeAlways;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefaults objectForKey:USER_NAME];
    if (username && username.length!=0) {
        self.nameField.text = username;
    }
    NSString *password = [userDefaults objectForKey:USER_PASSWORD];
    if (password && password.length != 0) {
        self.passwordField.text = password;
    }
}

- (BOOL)canAutoLogin
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefaults objectForKey:USER_NAME];
    NSString *password = [userDefaults objectForKey:USER_PASSWORD];
    
    if (!username || !password)       return NO;
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginIn
{
    [[FFXPManager defaultManager] connectWithBlock:^(BOOL success, id obj, NSError *error)
     {
         [PCNotificationCenter showMessage:(NSString*)obj];
         if (success) {
             [APP_DELEGATE showMainPage];
         }
         else
         {
             
         }
     }];

}
- (IBAction)loginButtonClicked:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setObject:self.nameField.text forKey:USER_NAME];
    [[NSUserDefaults standardUserDefaults] setObject:self.passwordField.text forKey:USER_PASSWORD];
    [[NSUserDefaults standardUserDefaults] setBool:self.autoLoginButton.selected forKey:USER_AUTOLOGIN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self loginIn];
}

- (IBAction)registerButtonClicked:(id)sender
{
    FFRegisterViewController *rvc = [[FFRegisterViewController alloc] init];
    [self presentViewController:rvc animated:YES completion:nil];
}
- (IBAction)autoClicked:(id)sender
{
    self.autoLoginButton.selected = !self.autoLoginButton.selected;
}
@end
