//
//  FFSettingViewController.m
//  W-Chat
//
//  Created by 冯明白 on 14-7-4.
//  Copyright (c) 2014年 HL. All rights reserved.
//

#import "FFSettingViewController.h"

@interface FFSettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation FFSettingViewController
{
    UITableView *_tabView;
    
    NSMutableArray *datas;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        datas = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)initSubView
{
    _tabView = [[UITableView alloc] initWithFrame:self.view.frame];
    _tabView.delegate =self;
    _tabView.dataSource =self;
    _tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tabView];
}


#pragma mark -------------UITableViewDelegata DataSource------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"settingCell";
    UITableViewCell *c = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (c == nil) {
        c = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        c.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    c.textLabel.textAlignment = NSTextAlignmentCenter;
    c.textLabel.text = @"切换账号";
    return c;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [APP_DELEGATE showLoginPage];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
