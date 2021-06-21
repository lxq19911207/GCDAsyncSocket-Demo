//
//  ViewController.m
//  GCDAsyncSocket-Demo
//
//  Created by 任忠旭 on 2021/6/21.
//

#import "ViewController.h"
#import <CocoaAsyncSocket/GCDAsyncSocket.h>
#import <Masonry/Masonry.h>

@interface ViewController ()<GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *serverSocket;
@property (nonatomic, strong) GCDAsyncSocket *clientSocket;

@property (nonatomic, strong) UILabel *serverTitleLabel;
@property (nonatomic, strong) UILabel *serverPortLabel;
@property (nonatomic, strong) UITextField *serverPortTextField;
@property (nonatomic, strong) UIButton *serverPortButton;

@property (nonatomic, strong) UILabel *clientTitleLabel;
@property (nonatomic, strong) UILabel *clientIPLabel;
@property (nonatomic, strong) UITextField *clientIPTextField;
@property (nonatomic, strong) UILabel *clientPortLabel;
@property (nonatomic, strong) UITextField *clientPortTextField;
@property (nonatomic, strong) UIButton *clientPortButton;

@property (nonatomic, strong) UITextField *messageTextField;
@property (nonatomic, strong) UIButton *receiveButton;
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UITextView *messageTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.serverSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    self.clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    [self init1];
    [self init2];
    [self init3];
}

- (void)init1 {

    UILabel *serverTitleLabel = [[UILabel alloc] init];
    serverTitleLabel.text = @"服务器配置";
    self.serverTitleLabel = serverTitleLabel;
    
    UILabel *serverPortLabel = [[UILabel alloc] init];
    serverPortLabel.text = @"端口";
    self.serverPortLabel = serverPortLabel;
    
    UITextField *serverPortTextField = [[UITextField alloc] init];
    serverPortTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.serverPortTextField = serverPortTextField;
    
    UIButton *serverPortButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [serverPortButton setTitle:@"开始" forState:UIControlStateNormal];
    [serverPortButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [serverPortButton addTarget:self action:@selector(serverPortButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.serverPortButton = serverPortButton;
    
    [self.view addSubview:serverTitleLabel];
    [self.view addSubview:serverPortLabel];
    [self.view addSubview:serverPortTextField];
    [self.view addSubview:serverPortButton];
    
    [serverTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(24);
    }];
    
    [serverPortLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(serverTitleLabel.mas_bottom).offset(25);
        make.left.mas_equalTo(serverTitleLabel);
    }];
    
    [serverPortTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(serverPortLabel);
        make.left.mas_equalTo(serverPortLabel.mas_right).offset(25);
        make.size.mas_equalTo(CGSizeMake(200, 35));
    }];
    
    [serverPortButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(serverPortLabel.mas_bottom).offset(25);
        make.left.mas_equalTo(serverTitleLabel);
    }];
}

- (void)init2 {
    
    UILabel *clientTitleLabel = [[UILabel alloc] init];
    clientTitleLabel.text = @"客户端配置";
    self.clientTitleLabel = clientTitleLabel;
    
    UILabel *clientIPLabel = [[UILabel alloc] init];
    clientIPLabel.text = @"IP";
    self.clientIPLabel = clientIPLabel;
    
    UITextField *clientIPTextField = [[UITextField alloc] init];
    clientIPTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.clientIPTextField = clientIPTextField;
    
    UILabel *clientPortLabel = [[UILabel alloc] init];
    clientPortLabel.text = @"端口";
    self.clientPortLabel = clientPortLabel;
    
    UITextField *clientPortTextField = [[UITextField alloc] init];
    clientPortTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.clientPortTextField = clientPortTextField;
    
    UIButton *clientPortButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clientPortButton setTitle:@"开始连接" forState:UIControlStateNormal];
    [clientPortButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [clientPortButton addTarget:self action:@selector(clientPortButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.clientPortButton = clientPortButton;
    
    [self.view addSubview:clientTitleLabel];
    [self.view addSubview:clientIPLabel];
    [self.view addSubview:clientIPTextField];
    [self.view addSubview:clientPortLabel];
    [self.view addSubview:clientPortTextField];
    [self.view addSubview:clientPortButton];
    
    [clientTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.serverPortButton.mas_bottom).offset(25);
        make.left.mas_equalTo(24);
    }];
    
    [clientIPLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(clientTitleLabel.mas_bottom).offset(25);
        make.left.mas_equalTo(clientTitleLabel);
    }];
    
    [clientIPTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(clientIPLabel);
        make.left.mas_equalTo(clientIPLabel.mas_right).offset(25);
        make.size.mas_equalTo(CGSizeMake(200, 35));
    }];
    
    [clientPortLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(clientIPLabel.mas_bottom).offset(25);
        make.left.mas_equalTo(clientTitleLabel);
    }];
    
    [clientPortTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(clientPortLabel);
        make.left.mas_equalTo(clientPortLabel.mas_right).offset(25);
        make.size.mas_equalTo(CGSizeMake(200, 35));
    }];
    
    [clientPortButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(clientPortLabel.mas_bottom).offset(25);
        make.left.mas_equalTo(clientTitleLabel);
    }];
}

- (void)init3 {
    
    UITextField *messageTextField = [[UITextField alloc] init];
    messageTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.messageTextField = messageTextField;
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendButton setTitle:@"发送消息" forState:UIControlStateNormal];
    [sendButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.sendButton = sendButton;
    
    UIButton *receiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [receiveButton setTitle:@"接收消息" forState:UIControlStateNormal];
    [receiveButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(receiveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.receiveButton = receiveButton;
    
    UITextView *messageTextView = [[UITextView alloc] init];
    messageTextView.backgroundColor = UIColor.darkGrayColor;
    self.messageTextView = messageTextView;
    
    [self.view addSubview:messageTextField];
    [self.view addSubview:sendButton];
    [self.view addSubview:receiveButton];
    [self.view addSubview:messageTextView];
    
    [messageTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.clientPortButton.mas_bottom).offset(25);
        make.left.mas_equalTo(24);
        make.size.mas_equalTo(CGSizeMake(200, 35));
    }];
    
    [sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(messageTextField);
        make.left.mas_equalTo(messageTextField.mas_right).offset(25);
    }];
    
    [receiveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(messageTextField.mas_bottom).offset(25);
        make.left.mas_equalTo(messageTextField);
    }];
    
    [messageTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(receiveButton.mas_bottom).offset(25);
        make.left.mas_equalTo(messageTextField);
        make.size.mas_equalTo(CGSizeMake(300, 150));
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)showMessageWithStr:(NSString*)str {
    self.messageTextView.text = [self.messageTextView.text stringByAppendingFormat:@"%@\n", str];
    [self.messageTextView setContentOffset:self.messageTextView.contentOffset animated:YES];
}
#pragma mark -
#pragma mark - GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket {
    self.clientSocket= newSocket;

    [self showMessageWithStr:@"链接成功"];

    [self showMessageWithStr:[NSString stringWithFormat:@"服务器地址：%@ -端口：%d", newSocket.connectedHost, newSocket.connectedPort]];

    [self.clientSocket readDataWithTimeout:-1 tag:0];

}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{

    [self showMessageWithStr:@"链接成功"];

    [self showMessageWithStr:[NSString stringWithFormat:@"服务器IP：%@", host]];

    [sock readDataWithTimeout:-1 tag:0];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{

    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    [self showMessageWithStr:text];

    [sock readDataWithTimeout:-1 tag:0];
}

#pragma mark -
#pragma mark - selector of the target
- (void)sendButtonClick:(UIButton *)sender {
    NSData *data = [self.messageTextField.text dataUsingEncoding:NSUTF8StringEncoding];
    [self.clientSocket writeData:data withTimeout:-1 tag:0];
}

- (void)receiveButtonClick:(UIButton *)sender {
    [self.clientSocket readDataWithTimeout:11 tag:0];
}

- (void)serverPortButtonClick:(UIButton *)sender {
    NSError *error = nil;
    BOOL result = [self.serverSocket acceptOnPort:self.serverPortTextField.text.integerValue error:&error];
    if(result && error == nil) {
        [self showMessageWithStr:[NSString stringWithFormat:@"开放端口:%ld成功", self.serverPortTextField.text.integerValue]];
    }
}

- (void)clientPortButtonClick:(UIButton *)sender {
    [self.clientSocket connectToHost:self.clientIPTextField.text onPort:self.clientPortTextField.text.integerValue withTimeout:-1 error:nil];
}

@end
