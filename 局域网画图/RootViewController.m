#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"画画板"];
    [[self view] setBackgroundColor:[UIColor whiteColor]];
    
    UIBarButtonItem *item_1 = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(showSendingView:)];
    [[self navigationItem] setLeftBarButtonItem:item_1 animated:YES];
    
    UIBarButtonItem *item_2 = [[UIBarButtonItem alloc] initWithTitle:@"接收" style:UIBarButtonItemStylePlain target:self action:@selector(showReceivingView:)];
    [[self navigationItem] setRightBarButtonItem:item_2 animated:YES];
    
    return;
}

/**
 *  发送按钮响应
 */
- (void)showSendingView:(UIBarButtonItem *)sender
{
    SendingViewController *sendingViewController = [[SendingViewController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:sendingViewController];
    [self presentViewController:navigation animated:YES completion:NULL];
    
    return;
}

/**
 *  接收按钮响应
 */
- (void)showReceivingView:(UIBarButtonItem *)sender
{
    ReceivingViewController *receivingViewController = [[ReceivingViewController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:receivingViewController];
    [self presentViewController:navigation animated:YES completion:NULL];
    
    return;
}

@end
