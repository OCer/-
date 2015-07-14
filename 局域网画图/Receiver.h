#import <Foundation/Foundation.h>

@class Receiver;
@protocol ReceiverDelegate <NSObject>

@optional
- (void)receiver:(Receiver *)receiver didReceiveData:(NSData *)data;

@end

@interface Receiver : NSObject

@property(nonatomic) UInt16 localPort;
@property(nonatomic, weak) id<ReceiverDelegate> delegate;

- (id)initWithPort:(UInt16)port;

/* 每次 disconnect 后重新 listen */
- (void)listen;

- (void)disconnect;

@end
