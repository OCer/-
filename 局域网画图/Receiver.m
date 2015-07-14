#import "Receiver.h"

#define READING_TAG     9999
#define HEADER_TAG      1111
#define BODY_TAG        2222
@interface Receiver () <AsyncSocketDelegate>
@end

@implementation Receiver
{
    AsyncSocket *asyncSocket;  // 监控链接
    AsyncSocket *remoteSocket; // 用来操作的链接
}

- (id)initWithPort:(UInt16)port
{
    self = [super init];
    if (self) {
        self.localPort = port;
        asyncSocket = [[AsyncSocket alloc] initWithDelegate:self];
    }
    return self;
}

- (void)listen
{
    if ( ![asyncSocket isConnected] )  // 判断是否在连接，如果没有，重新连接
    {
        NSError *error = NULL;
        if ( ![asyncSocket acceptOnPort:IMAGE_TRANSFER_PORT error:&error] )
            po( error );
    }
    
    return;
}

- (void)disconnect
{
    [asyncSocket disconnect]; // 立即断开，任何未处理的读或写都将被丢弃
    
    return;
}

#pragma mark - Delegate
- (void)onSocketDidDisconnect:(AsyncSocket *)sock // 断开连接并释放资源
{
    print_function();
    remoteSocket = nil;
    
    return;
}

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port // 当socket连接正准备读和写的时候调用，host属性是一个IP地址，而不是一个DNS 名称
{
    print_function();
    NSUInteger length = sizeof(NSUInteger);
    NSMutableData *buffer = [NSMutableData data];
    [remoteSocket readDataToLength:length withTimeout:-1 buffer:buffer bufferOffset:0 tag:HEADER_TAG]; // 读取给定的字节数,在给定的偏移开始，字节将被追加到给定的字节缓冲区
    
    return;
}

- (void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket // 当产生一个socket去处理连接时调用，此方法会返回线程上的run-loop的新的socket和其应处理的委托，如果省略，则使用[NSRunLoop cunrrentRunLoop]
{
    print_function();
    NSLog(@"Accept new socket: %@:%u", newSocket.connectedHost, newSocket.connectedPort);
    remoteSocket = newSocket;
    
    return;
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag  // 接收数据
{
    print_function();
    
    if (HEADER_TAG == tag)
    {
        NSUInteger length = 0;
        [data getBytes:&length length:sizeof(NSUInteger)]; // 复制一个字节数从接受数据的开始到一个被给予的buffer
        
        NSMutableData *buffer = [NSMutableData data];
        [remoteSocket readDataToLength:length withTimeout:-1 buffer:buffer bufferOffset:0 tag:BODY_TAG]; // 读取给定的字节数,在给定的偏移开始，字节将被追加到给定的字节缓冲区
    }
    else if (BODY_TAG == tag)
    {
        if ( !self.delegate )
        {
            return;
        }
        
        if ([self.delegate respondsToSelector:@selector(receiver:didReceiveData:)])
        {
            [self.delegate receiver:self didReceiveData:data];
        }
    }
    
    return;
}

@end
