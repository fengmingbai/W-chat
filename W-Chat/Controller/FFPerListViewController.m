//
//  FFPerListViewController.m
//  W-Chat
//
//  Created by 冯明白 on 14-7-4.
//  Copyright (c) 2014年 HL. All rights reserved.
//

#import "FFPerListViewController.h"
#import "FFXPManager.h"
#import "FFChatViewController.h"
@interface FFPerListViewController ()<FFPresenceDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *onLineUsers;
    NSMutableArray *offLineUsers;
    UITableView *_tableView;
}
@end

@implementation FFPerListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        onLineUsers = [NSMutableArray array];
        [onLineUsers addObject:@"11"];
        offLineUsers = [NSMutableArray array];
    }
    return self;
}

- (void)initSubView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}
#pragma mark ----------FFPresenceDelegate-------------
- (void)newBodyOnLine:(NSString *)bodyName
{
    [onLineUsers addObject:bodyName];
    [_tableView reloadData];
}
- (void)bodyWentOffLine:(NSString *)bodyName
{
    [offLineUsers addObject:bodyName];
    [onLineUsers removeObject:bodyName];
    [_tableView reloadData];
}
- (void)didDisconnect
{
    
}
#pragma mark -----------UITableViewDelegate/Datasouce--------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section) return offLineUsers.count;
    return onLineUsers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *perIdentifier = @"personCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:perIdentifier];
    if ( cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:perIdentifier];
    }
    NSString *perStr = nil;
    if (indexPath.row == 0) {
        perStr = [onLineUsers objectAtIndex:indexPath.row];
    }else
    {
        perStr = [offLineUsers objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = perStr;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FFChatViewController *ctvc =[[FFChatViewController alloc] init];
    [self.navigationController pushViewController:ctvc animated:YES];
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
