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
#import "CellPressGestureRecognizer.h"

typedef void(^alertBlock)( UIAlertAction* _Nonnull action );
@interface MessageViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
EMContactManagerDelegate,
AddMemberDelegate
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

@property(nonatomic,assign)BOOL list1IsUnfolding;
@property(nonatomic,assign)BOOL list2IsUnfolding;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.messageTableView.backgroundColor=[UIColor grayColor];
    self.friendsTableView.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    self.friendsTableView.bounces=NO;
    
    self.list2IsUnfolding=NO;
    self.list1IsUnfolding=NO;
    
    [self.messageTableView registerClass:[MessageListTableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.friendsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    
    //注册好友回调
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    
    self.hasShownMenu=NO;
    self.menu=[[MenuView alloc] initWithFrame:CGRectMake(self.scrollView.contentOffset.x, 0 , self.view.frame.size.width, self.view.frame.size.height)];
    self.menu.delegate=self;
    [self.scrollView addSubview:self.menu];
    [self.scrollView sendSubviewToBack:self.menu];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"+" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightBarButtonClicked)];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self notShowMenu];
    
}

-(void)rightBarButtonClicked{
    if (self.hasShownMenu) {
//        self.menu.frame=CGRectZero;
        [self notShowMenu];
    }else{
//        self.menu.frame=CGRectMake(self.scrollView.contentOffset.x, 0 , self.view.frame.size.width, self.view.frame.size.width);
        [self showMenu];
    }
}

-(void)notShowMenu{
    [self.scrollView sendSubviewToBack:self.menu];
    self.hasShownMenu=NO;
    [self.navigationItem.rightBarButtonItem setTitle:@"+"];
}
-(void)showMenu{
    self.menu.frame=CGRectMake(self.scrollView.contentOffset.x, 0 , self.view.frame.size.width, self.view.frame.size.height);
    [self.scrollView bringSubviewToFront:self.menu];
    self.hasShownMenu=YES;
    [self.navigationItem.rightBarButtonItem setTitle:@"-"];
}

- (IBAction)changePage:(UISegmentedControl *)sender {
    self.scrollView.contentOffset=CGPointMake(sender.selectedSegmentIndex*414, 0);
    if (self.hasShownMenu) {
        [self showMenu];
    }
}
//    NSLog(@"%d",self.hasShownMenu);
//    NSLog(@"%@",NSStringFromCGRect(self.menu.frame));


-(void)addFriend{
    [self notShowMenu];
#warning 此处方法封装有空继续搞 有研究价值
//    [self addMemberWithHandler:^(UIAlertAction * _Nonnull action) {
//        [self addFriendWithUserName:alertV.textFields.lastObject.text];
//    }];
    UIAlertController *alertV=[UIAlertController alertControllerWithTitle:@"添加好友" message:@"请输入添加好友的ID" preferredStyle:(UIAlertControllerStyleAlert)];
    //     UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"添加好友" message:@"请输入要添加好友的账号" preferredStyle:(UIAlertControllerStyleAlert)];
    [alertV addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"请输入ID";
    }];
    UIAlertAction *addAction=[UIAlertAction actionWithTitle:@"添加" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self addFriendWithUserName:alertV.textFields.lastObject.text];
    }];
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertV addAction:addAction];
    [alertV addAction:cancelAction];
    [self presentViewController:alertV animated:YES completion:^{
        
    }];
}

-(void)addBlackList{
    [self notShowMenu];
    UIAlertController *alertV=[UIAlertController alertControllerWithTitle:@"添加好友" message:@"请输入加入黑名单的ID" preferredStyle:(UIAlertControllerStyleAlert)];
    //     UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"添加好友" message:@"请输入要添加好友的账号" preferredStyle:(UIAlertControllerStyleAlert)];
    [alertV addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"请输入ID";
    }];
    UIAlertAction *addAction=[UIAlertAction actionWithTitle:@"添加" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self addFriendToBlackListWithUserName:alertV.textFields.lastObject.text];
    }];
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertV addAction:addAction];
    [alertV addAction:cancelAction];
    [self presentViewController:alertV animated:YES completion:^{
        
    }];
}

-(void)foldMenu{
    [self notShowMenu];
}

-(void)addMemberWithHandler:(alertBlock)alertAction{
    UIAlertController *alertV=[UIAlertController alertControllerWithTitle:@"添加好友" message:@"请输入添加好友的ID" preferredStyle:(UIAlertControllerStyleAlert)];
    //     UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"添加好友" message:@"请输入要添加好友的账号" preferredStyle:(UIAlertControllerStyleAlert)];
    [alertV addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"请输入ID";
    }];
    UIAlertAction *addAction=[UIAlertAction actionWithTitle:@"添加" style:(UIAlertActionStyleDefault) handler:alertAction];
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertV addAction:addAction];
    [alertV addAction:cancelAction];
    [self presentViewController:alertV animated:YES completion:^{
        
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestFriendList];
    [self requestBlackList];
    [self requestDialogueList];
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
//请求黑名单列表
-(void)requestBlackList{
    EMError *error = nil;
    NSArray *userlist = [[EMClient sharedClient].contactManager getBlackListFromServerWithError:&error];
    if (!error) {
//        NSLog(@"获取成功 -- %@",userlist);
//        NSLog(@"userlist个数 %ld",userlist.count);
        [[FriendManager shareFriendManager].blackListArray removeAllObjects];
        for (NSString *userName in userlist) {
            //遍历数组
            [[FriendManager shareFriendManager].blackListArray addObject:userName];
        }
        //刷新界面
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.friendsTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:(UITableViewRowAnimationFade)];
//            [self.messageTableView reloadData];
        });
    }else{
        NSLog(@"error = %@",error);
    }

}
//请求会话列表
-(void)requestDialogueList{
    NSArray *userlist = [[EMClient sharedClient].chatManager loadAllConversationsFromDB];
    [FriendManager shareFriendManager].dialogueArray=[NSArray arrayWithArray:userlist].mutableCopy;
//    NSLog(@"%@ %@",userlist,[FriendManager shareFriendManager].dialogueArray);
    [self.messageTableView reloadData];
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
        [self requestBlackList];
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
        [self alertWithTitle:@"提示" message:@"移出黑名单成功" actionTitle:@"确定"];
        [self requestBlackList];
    }else{
        [self alertWithTitle:@"提示" message:@"移出黑名单失败" actionTitle:@"确定"];
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
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==self.friendsTableView) {
        if (section==0) {
            if (self.list1IsUnfolding) {
                return [FriendManager shareFriendManager].friendsArray.count+1;
            }else{
                return 1;
            }
        }else{
            if (self.list2IsUnfolding) {
                return [FriendManager shareFriendManager].blackListArray.count+1;
            }else{
                return 1;
            }
        }
        return [FriendManager shareFriendManager].friendsArray.count;
    }else{
        return [FriendManager shareFriendManager].dialogueArray.count;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView==self.friendsTableView) {
        return 2;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.friendsTableView) {
        if (indexPath.section==0) {
            if (indexPath.row) {
                if (self.list1IsUnfolding) {
                    return 50;
                }else{
                    return 0;
                }
            }else{
                return 60;
            }
        }else{
            if (indexPath.row) {
                if (self.list2IsUnfolding) {
                    return 50;
                }else{
                    return 0;
                }
            }else{
                return 60;
            }
        }
    }else{
        return 80;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.friendsTableView) {
        UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (indexPath.row) {
            if (indexPath.section) {
                cell.textLabel.text=[NSString stringWithFormat:@"    %@",[FriendManager shareFriendManager].blackListArray[indexPath.row-1]];
                CellPressGestureRecognizer*press=[[CellPressGestureRecognizer alloc] initWithTarget:self action:@selector(operateBlackList:)];
                press.friendID=[FriendManager shareFriendManager].friendsArray[indexPath.row-1];
                press.indexPathRow=indexPath.row-1;
                [cell addGestureRecognizer:press];
            }else{
                cell.textLabel.text=[NSString stringWithFormat:@"    %@",[FriendManager shareFriendManager].friendsArray[indexPath.row-1]];
                CellPressGestureRecognizer*press=[[CellPressGestureRecognizer alloc] initWithTarget:self action:@selector(operateFriend:)];
                press.friendID=[FriendManager shareFriendManager].friendsArray[indexPath.row-1];
                press.indexPathRow=indexPath.row-1;
                [cell addGestureRecognizer:press];
            }
        }else{
            if (indexPath.section) {
                if (self.list2IsUnfolding) {
                    cell.textLabel.text=@" -  我的黑名单";
                }else{
                    cell.textLabel.text=@" +  我的黑名单";
                }
            }else{
                if (self.list1IsUnfolding) {
                    cell.textLabel.text=@" -  我的好友";
                }else{
                    cell.textLabel.text=@" +  我的好友";
                }
            }
        }
        return cell;
    }else{
//        MessageListTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (nil==cell) {
            cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
        }
        
        EMConversation *conversation = [FriendManager shareFriendManager].dialogueArray[indexPath.row];
        NSLog(@"%@",[FriendManager shareFriendManager].dialogueArray);
        NSLog(@"%@",conversation.conversationId);
//        cell.userLabel.text = conversation.conversationId;
        cell.textLabel.text=conversation.conversationId;
//        NSLog(@"%@",cell.userLabel.text);
        //获取聊天消息
        NSMutableArray *msgArr = [NSMutableArray array];
        msgArr = [conversation loadMoreMessagesContain:nil before:-1 limit:20 from:nil direction:(EMMessageSearchDirectionUp)].mutableCopy;
        //    NSIndexPath *msgIndex = [NSIndexPath indexPathForRow:msgArr.count - 1 inSection:0];
        EMMessage *message = [msgArr lastObject];
        
        if (message.body.type==EMMessageBodyTypeImage) {
//            cell.LastMsgLabel.text=@"[[图片]图片]";
            cell.detailTextLabel.text=@"[图片]";
        }else if (message.body.type== EMMessageBodyTypeText){
            EMTextMessageBody *messageBody = (EMTextMessageBody *)message.body;
//            cell.LastMsgLabel.text = messageBody.text;
            
            cell.detailTextLabel.text=messageBody.text;
        }
//        NSLog(@" cell content %@",cell.LastMsgLabel.text);
        
        CellPressGestureRecognizer*press=[[CellPressGestureRecognizer alloc] initWithTarget:self action:@selector(operateSession:)];
        press.indexPathRow=indexPath.row;
        [cell addGestureRecognizer:press];
        
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
        if (indexPath.row) {
            if (!indexPath.section) {
                NSString *username=[FriendManager shareFriendManager].friendsArray[indexPath.row-1];
                [self performSegueWithIdentifier:@"ChatViewController" sender:username];
            }
        }else{
            if (indexPath.section) {
                if (self.list2IsUnfolding) {
                    self.list2IsUnfolding=NO;
//                    UITableViewCell*cell=[tableView cellForRowAtIndexPath:indexPath];
//                    cell.textLabel.text=@" +  我的黑名单";
                    [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
                }else{
                    self.list2IsUnfolding=YES;
                    [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
                }
            }else{
                if (self.list1IsUnfolding) {
                    self.list1IsUnfolding=NO;
                    [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
                }else{
                    self.list1IsUnfolding=YES;
                    [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
                }
            }
        }
    }else{
        UITableViewCell*cell=[tableView cellForRowAtIndexPath:indexPath];
        NSString *username=cell.textLabel.text;
        [self performSegueWithIdentifier:@"ChatViewController" sender:username];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"ChatViewController"]) {
        ChatViewController*chatVC=segue.destinationViewController;
        chatVC.username=sender;
    }
}

-(void)operateFriend:(CellPressGestureRecognizer*)sender{
    UIAlertController*alertC=[UIAlertController alertControllerWithTitle:@"我的好友" message:@"" preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction*action1=[UIAlertAction actionWithTitle:@"发送消息" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self performSegueWithIdentifier:@"ChatViewController" sender:sender.friendID];
    }];
    [alertC addAction:action1];
    UIAlertAction*action2=[UIAlertAction actionWithTitle:@"删除好友" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        [self deleteFriendsWithUserName:sender.friendID];
    }];
    [alertC addAction:action2];
    UIAlertAction*action3=[UIAlertAction actionWithTitle:@"加入黑名单" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        [self deleteFriendsWithUserName:sender.friendID];
        [self addFriendToBlackListWithUserName:sender.friendID];
    }];
    [alertC addAction:action3];
    UIAlertAction*action4=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertC addAction:action4];
    [self presentViewController:alertC animated:YES completion:^{
        
    }];
}
-(void)operateBlackList:(CellPressGestureRecognizer*)sender{
    UIAlertController*alertC=[UIAlertController alertControllerWithTitle:@"我的黑名单" message:@"" preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction*action2=[UIAlertAction actionWithTitle:@"移出黑名单" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self removeBlacklistWithUsername:sender.friendID];
    }];
    [alertC addAction:action2];
    UIAlertAction*action3=[UIAlertAction actionWithTitle:@"加为好友" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self removeBlacklistWithUsername:sender.friendID];
        [self addFriendWithUserName:sender.friendID];
    }];
    [alertC addAction:action3];
    UIAlertAction*action4=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertC addAction:action4];
    [self presentViewController:alertC animated:YES completion:^{
        
    }];
}
-(void)operateSession:(CellPressGestureRecognizer*)sender{
    UIAlertController*alertC=[UIAlertController alertControllerWithTitle:@"我的消息" message:@"" preferredStyle:(UIAlertControllerStyleActionSheet)];
//    UIAlertAction*action2=[UIAlertAction actionWithTitle:@"移出黑名单" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//        [self removeBlacklistWithUsername:sender.friendID];
//    }];
//    [alertC addAction:action2];
    UIAlertAction*action3=[UIAlertAction actionWithTitle:@"删除会话" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [[FriendManager shareFriendManager].dialogueArray removeObjectAtIndex:sender.indexPathRow];
        [self.messageTableView reloadData];
    }];
    [alertC addAction:action3];
    UIAlertAction*action4=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertC addAction:action4];
    [self presentViewController:alertC animated:YES completion:^{
        
    }];
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
