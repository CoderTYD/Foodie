//
//  MessageViewController.m
//  Foodie
//
//  Created by 袁涛的大爷 on 16/7/22.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "MessageViewController.h"
#import <EMClient.h>
#import "FriendManager.h"
#import "MessageListTableViewCell.h"
//#import "ChattingViewController.h"
#import "ChatViewController.h"
#import "MenuView.h"

@interface MessageViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
EMContactManagerDelegate
>

{ //    用来存储编辑的样式
    UITableViewCellEditingStyle _editingStyle;
}
@property (nonatomic, copy) NSString *friendName;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *messageTableView;
@property (weak, nonatomic) IBOutlet UITableView *friendsTableView;

@property(nonatomic,assign)BOOL hasShownMenu;
@property(nonatomic,strong)MenuView*menu;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.messageTableView.backgroundColor=[UIColor blueColor];
    self.friendsTableView.backgroundColor=[UIColor magentaColor];
    
    [self.messageTableView registerClass:[MessageListTableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.friendsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    
    //注册好友回调
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    
    self.hasShownMenu=NO;
    self.menu=[[MenuView alloc] initWithFrame:CGRectMake(self.scrollView.contentOffset.x, 0 , self.view.frame.size.width, self.view.frame.size.height)];
    [self.scrollView addSubview:self.menu];
    [self.scrollView sendSubviewToBack:self.menu];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"+" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightBarButtonClicked)];
    
}

-(void)rightBarButtonClicked{
    if (self.hasShownMenu) {
//        self.menu.frame=CGRectZero;
        [self.scrollView sendSubviewToBack:self.menu];
        self.hasShownMenu=NO;
        [self.navigationItem.rightBarButtonItem setTitle:@"+"];
    }else{
//        self.menu.frame=CGRectMake(self.scrollView.contentOffset.x, 0 , self.view.frame.size.width, self.view.frame.size.width);
        self.menu.frame=CGRectMake(self.scrollView.contentOffset.x, 0 , self.view.frame.size.width, self.view.frame.size.height);
        [self.scrollView bringSubviewToFront:self.menu];
        self.hasShownMenu=YES;
        [self.navigationItem.rightBarButtonItem setTitle:@"-"];
    }
}
- (IBAction)changePage:(UISegmentedControl *)sender {
    self.scrollView.contentOffset=CGPointMake(sender.selectedSegmentIndex*414, 0);
    if (self.hasShownMenu) {
        self.menu.frame=CGRectMake(self.scrollView.contentOffset.x, 0 , self.view.frame.size.width, self.view.frame.size.height);
        [self.view bringSubviewToFront:self.menu];
    }
    NSLog(@"%d",self.hasShownMenu);
    NSLog(@"%@",NSStringFromCGRect(self.menu.frame));
}

-(void)viewWillAppear:(BOOL)animated{
    [self requestFriendList];
//    [self requestBlackList];
}
-(void)viewWillDisappear:(BOOL)animated{
    self.hidesBottomBarWhenPushed=NO;
}

//请求好友列表
- (void)requestFriendList{
    EMError *error = nil;
    NSArray *userlist = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
    if (!error) {
        NSLog(@"获取成功 -- %@",userlist);
        NSLog(@"userlist个数 %ld",userlist.count);
        [[FriendManager shareFriendManager].friendsArray removeAllObjects];
        for (NSString *userName in userlist) {
            //遍历数组
            [[FriendManager shareFriendManager].friendsArray addObject:userName];
        }
        //刷新界面
        NSLog(@" %p",[FriendManager shareFriendManager].friendsArray);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.friendsTableView reloadData];
            [self.messageTableView reloadData];
        });
    }else{
        NSLog(@"error = %@",error);
    }
}
//请求会话列表
-(NSArray*)requestDialogueList{
    NSArray *userlist = [[EMClient sharedClient].chatManager loadAllConversationsFromDB];
    return userlist;
}


/*
 *  用户A发送加用户B为好友的申请，用户B会收到这个回调
 *
 *  @param aUsername   用户名
 *  @param aMessage    附属信息
 */
- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername
                                       message:(NSString *)aMessage{
//    NSLog(@"收到%@的添加请求 提示信息:%@",aUsername,aMessage);
    NSString *message = [NSString stringWithFormat:@"收到%@的添加请求 提示信息:%@",aUsername,aMessage];
    UIAlertController*alertCtrller=[UIAlertController alertControllerWithTitle:@"好友请求" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction*action1=[UIAlertAction actionWithTitle:@"同意" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        //同意
        EMError *error1 = [[EMClient sharedClient].contactManager acceptInvitationForUsername:self.friendName];
        if (!error1) {
            [self alertWithTitle:@"提示" message:@"已同意" actionTitle:@"确定"];
        }
    }];
    UIAlertAction*action2=[UIAlertAction actionWithTitle:@"拒绝" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
//        拒绝
        EMError *error0 = [[EMClient sharedClient].contactManager declineInvitationForUsername:self.friendName];
        if (!error0) {
            [self alertWithTitle:@"提示" message:@"已拒绝" actionTitle:@"确定"];
        }
    }];
    [alertCtrller addAction:action1];
    [alertCtrller addAction:action2];
    [self presentViewController:alertCtrller animated:YES completion:^{
        
    }];
}

//添加好友
- (void)addFriendWithUserName:(NSString *)username{
    EMError *error = [[EMClient sharedClient].contactManager addContact:username message:@"支付宝转账15132051271"];
    if (!error) {
        [self alertWithTitle:@"提示" message:@"添加好友请求已发送" actionTitle:@"确定"];
    }else{
//        NSLog(@"add friend error = %@",error);
        NSString*string=[NSString stringWithFormat:@"错误信息:%@",error];
        [self alertWithTitle:@"发送失败" message:string actionTitle:@"确定"];
    }
}
//用户同意添加我好友之后的回调
- (void)didReceiveAgreedFromUsername:(NSString *)aUsername{
    NSLog(@"%@同意添加",aUsername);
    NSString*string=[NSString stringWithFormat:@"%@同意添加",aUsername];
    [self alertWithTitle:@"提示" message:string actionTitle:@"确定"];
    [self requestFriendList];
}
//用户拒绝添加我好友之后的回调
- (void)didReceiveDeclinedFromUsername:(NSString *)aUsername{
    NSLog(@"被%@拒绝",aUsername);
    NSString*string=[NSString stringWithFormat:@"被%@拒绝",aUsername];
    [self alertWithTitle:@"提示" message:string actionTitle:@"确定"];
    
}
//删除好友
- (void)deleteFriendsWithUserName:(NSString *)username{
    EMError *error = [[EMClient sharedClient].contactManager deleteContact:username];
    if (!error) {
        [self alertWithTitle:@"提示" message:@"删除成功" actionTitle:@"确定"];
        [self requestFriendList];
    }else{
        [self alertWithTitle:@"提示" message:@"删除失败" actionTitle:@"确定"];
    }
}

-(void)alertWithTitle:(NSString*)title
              message:(NSString*)message
          actionTitle:(NSString*)actionTitle{
    UIAlertController*nextAlertC=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction*action=[UIAlertAction actionWithTitle:actionTitle style:(UIAlertActionStyleDefault) handler:nil];
    [nextAlertC addAction:action];
    [self presentViewController:nextAlertC animated:YES
                     completion:nil];

}

#warning 添加黑名单方法
//加入黑名单
- (void)addFriendToBlackListWithUserName:(NSString *)username{
    EMError *error = [[EMClient sharedClient].contactManager addUserToBlackList:username relationshipBoth:YES];
    if (!error) {
        NSLog(@"发送成功");
        [self alertWithTitle:@"提示" message:@"添加黑名单成功" actionTitle:@"确定"];
        [self requestFriendList];
    }else{
        [self alertWithTitle:@"提示" message:@"添加黑名单失败" actionTitle:@"确定"];
    }
}
//移除黑名单
- (void)removeBlacklistWithUsername:(NSString *)username{
    // 将6001移除黑名单
    EMError *error = [[EMClient sharedClient].contactManager removeUserFromBlackList:@"6001"];
    if (!error) {
        NSLog(@"发送成功");
        [self alertWithTitle:@"提示" message:@"移除黑名单成功" actionTitle:@"确定"];
        [self requestFriendList];
    }else{
        [self alertWithTitle:@"提示" message:@"移除黑名单失败" actionTitle:@"确定"];
    }
}

#pragma mark--获取所有会话列表--
- (NSArray *)getConversationList{
    return [[EMClient sharedClient].chatManager loadAllConversationsFromDB];
}


#pragma mark--删除会话--
- (void)deleteConversation:(NSString *)userID{
    [[EMClient sharedClient].chatManager deleteConversation:userID deleteMessages:YES];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==self.friendsTableView) {
        return [FriendManager shareFriendManager].friendsArray.count;
    }else{
        return [self requestDialogueList].count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.friendsTableView) {
        UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell2"];
        cell.textLabel.text=[FriendManager shareFriendManager].friendsArray[indexPath.row];
        return cell;
    }else{
        MessageListTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        
        
        EMConversation *conversation = [self requestDialogueList][indexPath.row];
        cell.userLabel.text = conversation.conversationId;
        
        //获取聊天消息
        NSMutableArray *msgArr = [NSMutableArray array];
        msgArr = [conversation loadMoreMessagesContain:nil before:-1 limit:20 from:nil direction:(EMMessageSearchDirectionUp)].mutableCopy;
        //    NSIndexPath *msgIndex = [NSIndexPath indexPathForRow:msgArr.count - 1 inSection:0];
        EMMessage *message = [msgArr lastObject];
        
        if (message.body.type==EMMessageBodyTypeImage) {
            cell.LastMsgLabel.text=@"[图片]";
        }else if (message.body.type== EMMessageBodyTypeText){
            EMTextMessageBody *messageBody = (EMTextMessageBody *)message.body;
            cell.LastMsgLabel.text = messageBody.text;
        }
        return cell;
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//第四步：提交编辑结果
    [self deleteFriendsWithUserName:[FriendManager shareFriendManager].friendsArray[indexPath.row]];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    ChattingViewController*chatVC=[ChattingViewController new];
//    UIStoryboard*sb=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    ChatViewController*chatVC=[sb instantiateViewControllerWithIdentifier:@"ChatViewController"];
    if (tableView==self.friendsTableView) {
        NSString *username=[FriendManager shareFriendManager].friendsArray[indexPath.row];
        [self performSegueWithIdentifier:@"ChatViewController" sender:username];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"ChatViewController"]) {
        ChatViewController*chatVC=segue.destinationViewController;
        chatVC.username=sender;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
