#import <UIKit/UIKit.h>
#import "MyView.h"
#import "Sender.h"

@interface SendingViewController : UIViewController<UITextFieldDelegate, MyViewDelegate>

@property(nonatomic, strong) MyView *myView;
@property(nonatomic, strong) UITextField *textField;

@end
