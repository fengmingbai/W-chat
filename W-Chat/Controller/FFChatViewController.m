//
//  FFChatViewController.m
//  W-Chat
//
//  Created by 冯明白 on 14-7-4.
//  Copyright (c) 2014年 HL. All rights reserved.
//

#import "FFChatViewController.h"
#import "FFMessageOBJ.h"
#import "FFSendMessageView.h"
#import "FFXPManager.h"

@interface FFChatViewController ()<UITableViewDataSource,UITableViewDelegate,FFSendMessageViewDelegate>
{
    NSMutableArray *messages;
    UITableView *_tableView;
    FFSendMessageView *sendView;
    CGRect sendFrame;
}
@end

@implementation FFChatViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        messages = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    sendFrame = sendView.frame;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getMessage:) name:kMessage_chat object:nil];
    
    self.title = self.bodyName;
}

- (void)initSubView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    sendView = [[FFSendMessageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), 320, 44)];
    [self.view addSubview:sendView];
}

-(void)addKeyboardObserver
{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark -----------keyboard notification--------------
- (void)keyboardWillHide:(NSNotification *)notification
{
    
    float animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:animationDuration animations:^{
        sendView.frame =sendFrame;
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSLogInfo(@"[notification userInfo] is %@",[notification userInfo]);
    
    float animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat height = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [UIView animateWithDuration:animationDuration animations:^{
        sendView.bottom = height;

    } completion:^(BOOL finished) {
    }];
    
}


#pragma mark -------------NSNotification----------
- (void)getMessage:(NSNotification *)notify
{
    FFMessageOBJ *message = (FFMessageOBJ*)notify.object;
    [messages addObject:message];
    [_tableView reloadData];
}

#pragma mark -----------UITableViewDelegate Datasouce------------

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

#pragma mark ----------FFSendMessageViewDelegate---------

- (void)sendMessage:(NSString *)textMessage
{
    NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
    [body setStringValue:textMessage];
    
    NSXMLElement *mes = [NSXMLElement elementWithName:@"message"];
    [mes addAttributeWithName:@"type" stringValue:@"chat"];
    [mes addAttributeWithName:@"to" stringValue:self.bodyName];
    [mes addAttributeWithName:@"from" stringValue:[[NSUserDefaults standardUserDefaults] stringForKey:USER_NAME]];
    
    [mes addChild:body];
    XMPPStream *sm = [[FFXPManager defaultManager] xmppStream];
    [sm sendElement:mes];
    
    [sendView.textField resignFirstResponder];
    
    FFMessageOBJ *msg = [[FFMessageOBJ alloc] init];
    msg.messageBody = textMessage;
    msg.fromP = @"me";
    [messages addObject:msg];
    [_tableView reloadData];
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
