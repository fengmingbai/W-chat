//
//  FFRegisterViewController.h
//  W-Chat
//
//  Created by 冯明白 on 14-7-2.
//  Copyright (c) 2014年 HL. All rights reserved.
//

#import "FFBaseViewController.h"

@interface FFRegisterViewController : FFBaseViewController
@property (weak, nonatomic) IBOutlet UITextField *loginName;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)regiserSend:(id)sender;
- (IBAction)backLogin:(id)sender;

@end
