#import "MyView.h"

@implementation MyView

- (NSMutableArray *)data
{
    if(_data == nil)
    {
        [self setData:[[NSMutableArray alloc] initWithCapacity:100]];
    }
    
    return _data;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    	
    if(self) 
    {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    
    return self;
}

/**
 *  添加点
 */
- (void)addArrayObj:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    UIBezierPath *path = [[self data] lastObject];
    [path addLineToPoint:point]; // 设置后面的点
    [self setNeedsDisplay];
    
    id delegate = [self delegate];
    if((delegate != nil) && ([delegate respondsToSelector:@selector(myViewTouch:)]))
    {
        [delegate myViewTouch:self];
    }
    
    return;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    UIBezierPath *path = [[UIBezierPath alloc] init];  // 创建一个绘图路径
    
    Model *model = [Model sharedModel];
    
    [path setLineCapStyle:[model lineCapStyle]];
    [path setLineJoinStyle:[model lineJoinStyle]];
    [path setLineWidth:[model lineWidth]];
    [path moveToPoint:point];  // 设置第一个点
    
    [[self data] addObject:path];

    return;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self addArrayObj:touches];
    
    return;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self addArrayObj:touches];
    
    return;
}

- (void)drawRect:(CGRect)rect
{
    NSMutableArray *data = [self data];
    
    for(UIBezierPath *path in data)
    {
        [[[Model sharedModel] color] set];    // 设置颜色
        [path stroke];  // 绘图
    }
    
    return;
}

@end
