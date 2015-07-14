#import "ReceivingViewController.h"

@implementation ReceivingViewController
{
    Receiver *dataReceiver;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor lightGrayColor]];
    [self setTitle:@"接收"];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissViewController:)];
    [[self navigationItem] setRightBarButtonItem:item animated:YES];
    
    static NSString *ipAddr = nil;
    if (ipAddr == nil) {
        ipAddr = [DeviceInfo IPAddress];
    }

    dataReceiver = [[Receiver alloc] initWithPort:IMAGE_TRANSFER_PORT];
    dataReceiver.delegate = self;
    
    UILabel *label = [[UILabel alloc] init];
    [label setFrame:CGRectMake(10, 70, 200, 30)];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setText:[NSString stringWithFormat:@"本机IP：%@", ipAddr]];
    [[self view] addSubview:label];
    
    MyView *view = [[MyView alloc] init];
    [view setFrame:CGRectMake(10, 110, kScreenWidth - 20, kScreenHeight - 120)];
    [view setUserInteractionEnabled:NO];
    [self setMyView:view];
    [[self view] addSubview:view];
    
    return;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [dataReceiver listen];
    
    return;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [dataReceiver disconnect];
    
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

#pragma mark - Delegate
- (void)receiver:(Receiver *)receiver didReceiveData:(NSData *)data
{
    NSKeyedUnarchiver *un = [[NSKeyedUnarchiver alloc] initForReadingWithData:data]; // 解档
    NSMutableArray *array = [un decodeObjectForKey:@"array"];
    [[self myView] setData:array];
    [[self myView] setNeedsDisplay];
    
    return;
}

@end
