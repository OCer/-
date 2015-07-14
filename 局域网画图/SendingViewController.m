#import "SendingViewController.h"

@interface SendingViewController ()

@end

@implementation SendingViewController
{
    Sender *dataSender;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField     // 进入编辑模式时自动调用该方法
{
    [[self myView] setUserInteractionEnabled:NO];
    
    return;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField  // 点击return按钮是否可以响应
{
    [textField resignFirstResponder];  // 取消第一响应者（退出编辑模式，收起键盘）
    [[self myView] setUserInteractionEnabled:YES];
    
    return YES; // 默认是YES，NO为不响应
}

- (void)myViewTouch:(MyView *)myView
{
    NSMutableArray *array = [myView data];
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data]; // 用data做缓存区
    [archiver encodeObject:array forKey:@"array"];
    [archiver finishEncoding];  // 完成归档；档案内容被写到data里

    dataSender = nil;
    dataSender = [[Sender alloc] initWithRemoteAddress:self.textField.text onPort:IMAGE_TRANSFER_PORT];
    [dataSender sendData:data];

    return;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor lightGrayColor]];
    [self setTitle:@"发送"];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissViewController:)];
    [[self navigationItem] setRightBarButtonItem:item animated:YES];
    
    UILabel *label = [[UILabel alloc] init];
    [label setFrame:CGRectMake(10, 70, 80, 30)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"远程IP："];
    [[self view] addSubview:label];
    
    UITextField *tf = [[UITextField alloc] init];
    [tf setFrame:CGRectMake(90, 70, 200, 30)];
    [tf setPlaceholder:@"0.0.0.0"];
    [tf setText:@"192.168.0.3"];
    [tf setBorderStyle:UITextBorderStyleRoundedRect];
    [tf setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [tf setReturnKeyType:UIReturnKeyDone];
    [tf setClearButtonMode:UITextFieldViewModeWhileEditing];
    [tf setTextAlignment:NSTextAlignmentCenter];
    [tf setDelegate:self];
    [self setTextField:tf];
    [[self view] addSubview:tf];
    
    MyView *view = [[MyView alloc] init];
    [view setFrame:CGRectMake(10, 110, kScreenWidth - 20, kScreenHeight - 120)];
    [view setDelegate:self];
    [self setMyView:view];
    [[self view] addSubview:view];
    
    return;
}

/**
 *  完成按钮响应
 */
- (void)dismissViewController:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    return;
}

@end
