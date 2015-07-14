#import "Model.h"

@implementation Model

- (instancetype)init
{
    if(self = [super init])
    {
        [self setColor:[UIColor greenColor]];
        [self setLineWidth:5.0f];
        [self setLineCapStyle:kCGLineCapRound];
        [self setLineJoinStyle:kCGLineJoinRound];
    }
    
    return self;
}

+ (instancetype)sharedModel
{
    static Model *temp = nil;
    
    @synchronized(self)
    {
        if(temp == nil)
        {
            temp = [[[self class] alloc] init]; // 等价于[[self alloc] init]
        }
    }
    
    return temp;
}

@end
