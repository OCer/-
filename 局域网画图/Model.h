#import <Foundation/Foundation.h>

@interface Model : NSObject

@property(nonatomic, strong) UIColor        *color;
@property(nonatomic, assign) CGFloat        lineWidth;
@property(nonatomic, assign) CGLineCap      lineCapStyle;
@property(nonatomic, assign) CGLineJoin     lineJoinStyle;

+ (instancetype)sharedModel;

@end
