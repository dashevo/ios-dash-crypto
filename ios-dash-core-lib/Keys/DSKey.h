//
//  DSKey.h
//  DashSync
//
//  Created by Sam Westrich on 2/14/19.
//

#import <Foundation/Foundation.h>

#import "DSChainProtocol.h"
#import "BigIntTypes.h"

NS_ASSUME_NONNULL_BEGIN

@interface DSKey : NSObject

@property (nullable, nonatomic, readonly) NSData *publicKeyData;
@property (nonatomic, readonly) UInt160 hash160;
@property (nonatomic,readonly) NSString * secretKeyString;

- (NSString *)addressForChain:(id<DSChainProtocol>)chain;
+ (NSString *)randomAddressForChain:(id<DSChainProtocol>)chain;
+ (NSString *)addressWithPublicKeyData:(NSData*)data forChain:(id<DSChainProtocol>)chain;
- (NSString * _Nullable)privateKeyStringForChain:(id<DSChainProtocol>)chain;

@end

NS_ASSUME_NONNULL_END
