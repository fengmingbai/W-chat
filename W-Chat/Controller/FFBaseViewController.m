//
//  FFBaseViewController.m
//  W-Chat
//
//  Created by 冯明白 on 14-7-2.
//  Copyright (c) 2014年 HL. All rights reserved.
//

#import "FFBaseViewController.h"

@interface FFBaseViewController ()

@end

@implementation FFBaseViewController


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
    [self initSubView];
    [[UINavigationBar appearance] setBackgroundColor:[UIColor darkGrayColor]];

}

- (void)initSubView
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
