#import <UIKit/UIKit.h>
#import "MyView.h"
#import "Receiver.h"

@interface ReceivingViewController : UIViewController<ReceiverDelegate>

@property(nonatomic, strong) MyView *myView;

@end
