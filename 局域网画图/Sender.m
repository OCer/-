#import "Sender.h"

#define  SENDING_TAG        10000
@interface Sender () <AsyncSocketDelegate>

@end

@implementation Sender
{
    AsyncSocket *asyncSocket;
}


- (id)initWithRemoteAddress:(NSString *)address onPort:(UInt16)port
{
    self = [super init];
    if (self) {
        self.remoteAddress = address;
        self.remotePort    = port;
        
        asyncSocket = [[AsyncSocket alloc] initWithDelegate:self];
    }
    return self;
}

/**
 *  发送数据
 */
- (void)sendData:(NSData *)data
{
    if ( [self connectToRemote] )
    {
        NSData *sendingData = [self prepareData:data];
        [asyncSocket writeData:sendingData withTimeout:-1 tag:SENDING_TAG];
    }
}

/**
 * 每次发送的data为两部分
 * header 内容数据的字节长度
 * body 内容数据
 */
- (NSData *)prepareData:(NSData *)data
{
    NSUInteger length = [data length];
    NSMutableData *sendingData = [[NSMutableData alloc] init];
    [sendingData appendBytes:&length length:sizeof(NSUInteger)];
    [sendingData appendData:data];
    return sendingData;
}

/**
 *  查看是否可以发送数据
 */
- (BOOL)connectToRemote
{
    BOOL success = YES;
    NSError *error = nil;
    if ( ![asyncSocket connectToHost:self.remoteAddress onPort:self.remotePort error:&error] )
    {
        success = NO;
        NSLog(@"Could not connet to %@:%d", self.remoteAddress, self.remotePort);
    }
    if (error)
    {
        success = NO;
        po(error); // 打印错误信息
    }
    
    return success;
}

@end
