//
//  FFLoginViewController.h
//  W-Chat
//
//  Created by 冯明白 on 14-7-2.
//  Copyright (c) 2014年 HL. All rights reserved.
//

#import "FFBaseViewController.h"

@interface FFLoginViewController : FFBaseViewController
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (assign, nonatomic)BOOL noAutoLogin;

- (IBAction)loginButtonClicked:(id)sender;
- (IBAction)registerButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *autoLoginButton;
- (IBAction)autoClicked:(id)sender;

@end
