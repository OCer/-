#import <UIKit/UIKit.h>
#import "Model.h"

@class MyView;

@class MyView;

@protocol MyViewDelegate<NSObject>

- (void)myViewTouch:(MyView *)myView; // 触摸的代理

@end

@interface MyView : UIView

@property(nonatomic, strong) NSMutableArray *data;
@property(nonatomic, weak) id<MyViewDelegate> delegate;

@end
