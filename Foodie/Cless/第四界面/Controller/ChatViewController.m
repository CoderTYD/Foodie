//
//  ChatViewController.m
//  LessonHuanXin
//
//  Created by 袁涛的大爷 on 16/7/6.
//  Copyright © 2016年 zhangzhen. All rights reserved.
//

#import "ChatViewController.h"
//#import "EMSDK.h"
#import "MessageCell.h"
#import "AlternativeMessageCell.h"
#import "ImageMessageCell.h"
#import "AlternativeImageMessageCell.h"
#import "RootViewController.h"

@interface ChatViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
EMChatManagerDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
//所有消息
@property(nonatomic,strong)NSMutableArray*msgArr;
@property(nonatomic,strong)UITextView *msgTextView;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title=[NSString stringWithFormat:@"和%@聊天",self.username];
    [self addSendView];
    [self.chatTableView registerNib:[UINib nibWithNibName:@"MessageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"messageCell"];
    [self.chatTableView registerNib:[UINib nibWithNibName:@"AlternativeMessageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:alternative_Identifier];
    [self.chatTableView registerNib:[UINib nibWithNibName:@"ImageMessageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"image"];
    [self.chatTableView registerNib:[UINib nibWithNibName:@"AlternativeImageMessageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"alterimage"];
    // Do any additional setup after loading the view.
    
    //获取或者创建一个会话
//    EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:@"8001" type:EMConversationTypeChat createIfNotExist:YES];
//    self.msgArr=[conversation loadMoreMessagesContain:nil before:-1 limit:20 from:nil direction:(EMMessageSearchDirectionUp)].mutableCopy;
    [self.chatTableView reloadData];

    //回到最后
    [self scrollViewToButton];
    
//    //消息回调:EMChatManagerChatDelegate
    //注册消息回调
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
//    //移除消息回调
//    [[EMClient sharedClient].chatManager removeDelegate:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed=YES;
//    UIStoryboard*storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    RootViewController*rootVC=[storyBoard instantiateViewControllerWithIdentifier:@"RootViewController"];
////    [rootVC.view sendSubviewToBack:rootVC.dbTabBar];
//    [rootVC hideTabBar];
////    rootVC.dbTabBar.hidden=YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hide" object:nil];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed=NO;
//    UIStoryboard*storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    RootViewController*rootVC=[storyBoard instantiateViewControllerWithIdentifier:@"RootViewController"];
////    rootVC.dbTabBar.hidden=NO;
//    [rootVC.view bringSubviewToFront:rootVC.dbTabBar];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"show" object:nil];
    //移除消息回调
    [[EMClient sharedClient].chatManager removeDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)msgArr{
    if (!_msgArr) {
        _msgArr=[NSMutableArray array];
    }
    return _msgArr;
}

- (void)addSendView{
    UITextView*textView=[[UITextView alloc]initWithFrame:CGRectMake(40, self.view.frame.size.height-50, self.view.frame.size.width-120, 40)];
    textView.layer.cornerRadius=5;
    textView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:textView];
    self.msgTextView=textView;
    UIButton*sendButton=[UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame=CGRectMake(self.view.bounds.size.width-70, self.view.frame.size.height-50, 60, 40);
    [sendButton addTarget:self action:@selector(sendMsg:) forControlEvents:(UIControlEventTouchUpInside)];
    sendButton.backgroundColor=[UIColor whiteColor];
    sendButton.layer.cornerRadius=5;
    [sendButton setTitle:@"发送" forState:(UIControlStateNormal)];
    [sendButton setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [self.view addSubview:sendButton];
    UIButton*picBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    picBtn.frame=CGRectMake(5, self.view.frame.size.height-46, 30, 30);
    [picBtn addTarget:self action:@selector(sendPic:) forControlEvents:(UIControlEventTouchUpInside)];
    picBtn.backgroundColor=[UIColor whiteColor];
    picBtn.layer.cornerRadius=5;
    [picBtn setTitle:@"🐰" forState:(UIControlStateNormal)];
    [picBtn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [self.view addSubview:picBtn];
}

-(void)sendMsg:(UIButton*)sender{
    NSLog(@"btn");
    if (self.msgTextView.text.length>0) {
        //以下为发送消息的方法
        EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText: self.msgTextView.text];
        NSString *from = [[EMClient sharedClient] currentUsername];
        EMMessage *message = [[EMMessage alloc] initWithConversationID:self.username from:from to:self.username body:body ext:nil];
        message.chatType = EMChatTypeChat;// 设置为单聊消息
        __weak typeof(self)weakSelf=self;
        [[EMClient sharedClient].chatManager asyncSendMessage:message progress:nil completion:^(EMMessage *aMessage, EMError *aError) {
            [weakSelf.msgArr addObject:aMessage];
            //在主线程中刷新tableview
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.chatTableView reloadData];
                [weakSelf scrollViewToButton];
                self.msgTextView.text=@"";
            });
        }];
    }
}

//试图发送图片 但是崩了
- (void)sendPic:(UIButton *)sender{
    NSLog(@"🐰");
    UIImagePickerController * pc = [[UIImagePickerController alloc]init] ;
    pc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //是否允许被编辑
    pc.allowsEditing = YES;
    pc.delegate=self;
    [self presentViewController:pc animated:YES completion:^{
        
    }];
//    UIImage*image=[UIImage imageNamed:@"c2574e003af33a8768caf2dbc15c10385243b53f副本.jpg"];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *selectImage = [info objectForKey:UIImagePickerControllerEditedImage];
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    //退出
    [self dismissViewControllerAnimated:YES completion:^{
        
    } ];
    NSData*imageData=UIImageJPEGRepresentation(selectImage, 1);
    EMImageMessageBody *body = [[EMImageMessageBody alloc] initWithData:imageData displayName:@"image.png"];
    NSString *from = [[EMClient sharedClient] currentUsername];
    
    //生成Message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:self.username from:from to:self.username body:body ext:nil];
    message.chatType = EMChatTypeChat;// 设置为单聊消息    NSLog(@"🐰");
    __weak typeof(self)weakSelf=self;
    [[EMClient sharedClient].chatManager asyncSendMessage:message progress:nil completion:^(EMMessage *aMessage, EMError *aError) {
        [weakSelf.msgArr addObject:aMessage];
        //在主线程中刷新tableview
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.chatTableView reloadData];
            [weakSelf scrollViewToButton];
            self.msgTextView.text=@"";
        });
    }];
    
}
//
//在线接受普通消息回调
- (void)didReceiveMessages:(NSArray *)aMessages{
    for (EMMessage*message in aMessages) {
        if ([message.conversationId isEqualToString:self.username]) {
            [self.msgArr addObject:message];
        }
    }
    [self.chatTableView reloadData];
    
    [self scrollViewToButton];
    
}

//自动走到底部的方法
- (void)scrollViewToButton{
    if (self.msgArr.count<1) {
        return;
    }
    NSIndexPath *path=[NSIndexPath indexPathForRow:self.msgArr.count-1 inSection:0];
    //有时候要刷新特定行 同样用NSIndexPath控制
    //滑到tableView最后一行的最下面
    [self.chatTableView scrollToRowAtIndexPath:path atScrollPosition:(UITableViewScrollPositionBottom) animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EMMessage*message=self.msgArr[indexPath.row];
    EMMessageBody *msgBody = message.body;
//    if ([message.from isEqualToString:[[EMClient sharedClient] currentUsername]]) {
    //整数 if(a==0) 小数 if(a>-0.000001 && a<0.000001) bool if(a)
    //枚举的判断??? 面试题
//    if (message.direction == 0) {//发送方
//        MessageCell*cell=[tableView dequeueReusableCellWithIdentifier:@"messageCell"];
////        cell.textLabel.text=message.messageId;
////        NSLog(@"收到的文字是 txt -- %@",txt);
//        cell.label.text=textBody.text;
//        NSLog(@"%@=%@",cell.label.text,textBody.text);
//        return cell;
//    }else{
//        AlternativeMessageCell*cell=[tableView dequeueReusableCellWithIdentifier:alternative_Identifier];
//        cell.label.text=textBody.text;
//        NSLog(@"%@=%@",cell.label.text,textBody.text);
//        return cell;
    switch (msgBody.type) {
        case EMMessageBodyTypeText:{
            if (message.direction == 0) {//发送方
                        MessageCell*cell=[tableView dequeueReusableCellWithIdentifier:@"messageCell"];
                //        cell.textLabel.text=message.messageId;
                //        NSLog(@"收到的文字是 txt -- %@",txt);
                        cell.label.text=[(EMTextMessageBody*)msgBody text];
//                        NSLog(@"%@=%@",cell.label.text,textBody.text);
                        return cell;
                    }else{
                        AlternativeMessageCell*cell=[tableView dequeueReusableCellWithIdentifier:alternative_Identifier];
                        cell.label.text=[(EMTextMessageBody*)msgBody text];
//                        NSLog(@"%@=%@",cell.label.text,textBody.text);
                        return cell;
            break;
        }
        case EMMessageBodyTypeImage:{
            EMImageMessageBody*body=(EMImageMessageBody*)msgBody;
            if (message.direction==EMMessageDirectionSend) {
                ImageMessageCell*cell=[tableView dequeueReusableCellWithIdentifier:@"image"];
                cell.thumbImageV.image=[UIImage imageWithContentsOfFile:body.localPath];
                return cell;
            }else{
                AlternativeImageMessageCell*cell=[tableView dequeueReusableCellWithIdentifier:@"alterimage"];
                cell.thumbImageV.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:body.remotePath]]];
                return cell;
            }
            break;
        }
        default:
            return nil;
            break;
    }
    } 
}

    
//    MessageCell*cell=[tableView dequeueReusableCellWithIdentifier:@"messageCell"];
////    cell.textLabel.text=self.msgArr[indexPath.row];
//    return cell;


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.msgArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 100;
    EMMessage *message = _msgArr[indexPath.row];
    EMMessageBody *messageBody = message.body;
    
    //判断包体里面的数据类型
    switch (messageBody.type) {
        case EMMessageBodyTypeImage:{
            return 160;
            break;
        }
        default:{
            return 100;
        }
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
