//
//  FFMessageViewController.m
//  W-Chat
//
//  Created by 冯明白 on 14-7-4.
//  Copyright (c) 2014年 HL. All rights reserved.
//

#import "FFMessageViewController.h"
#import "FFXPManager.h"
#import "FFMessageOBJ.h"

@interface FFMessageViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *messages;
    UITableView *_tableView;
}
@end

@implementation FFMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        messages = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)initSubView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark -------------FFMessageDelegate----------
- (void)getMessage:(FFMessageOBJ *)message
{
    [messages addObject:message];
    [_tableView reloadData];
}

#pragma mark UITableViewDelegate Datasouce------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *msgIdentifier = @"messageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:msgIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:msgIdentifier];
    }
    FFMessageOBJ *msgObj = [messages objectAtIndex:indexPath.row];
    cell.textLabel.text = msgObj.messageBody;
    cell.detailTextLabel.text = msgObj.fromP;
    return cell;
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
