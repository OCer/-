#import <Foundation/Foundation.h>

@interface Sender : NSObject

@property(nonatomic, copy) NSString *remoteAddress;
@property(nonatomic) UInt16 remotePort;

- (id)initWithRemoteAddress:(NSString *)address onPort:(UInt16)port;
- (void)sendData:(NSData *)data;

@end
