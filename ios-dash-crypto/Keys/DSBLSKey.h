//
//  Created by Sam Westrich
//  Copyright © 2019 Dash Core Group. All rights reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  https://opensource.org/licenses/MIT
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import <Foundation/Foundation.h>

#import "BigIntTypes.h"
#import "DSChainProtocol.h"
#import "DSKey.h"

NS_ASSUME_NONNULL_BEGIN

@interface DSBLSKey : DSKey

@property (nonatomic, readonly) uint32_t publicKeyFingerprint;
@property (nonatomic, readonly) UInt256 chainCode;
@property (nonatomic, readonly) id<DSChainProtocol> chain;
@property (nonatomic, readonly) NSData *extendedPrivateKeyData;
@property (nonatomic, readonly) NSData *extendedPublicKeyData;
@property (nonatomic, readonly) UInt256 secretKey;
@property (nonatomic, readonly) UInt384 publicKey;

+ (nullable instancetype)blsKeyWithPrivateKeyFromSeed:(NSData *)seed onChain:(id<DSChainProtocol>)chain;
- (nullable instancetype)initWithPrivateKeyFromSeed:(NSData *)seed onChain:(id<DSChainProtocol>)chain;
+ (nullable instancetype)blsKeyWithExtendedPrivateKeyFromSeed:(NSData *)seed onChain:(id<DSChainProtocol>)chain;
- (nullable instancetype)initWithExtendedPrivateKeyFromSeed:(NSData *)seed onChain:(id<DSChainProtocol>)chain;
+ (nullable instancetype)blsKeyWithExtendedPublicKeyData:(NSData *)extendedPublicKey onChain:(id<DSChainProtocol>)chain;
- (nullable instancetype)initWithExtendedPublicKeyData:(NSData *)extendedPublicKey onChain:(id<DSChainProtocol>)chain;
+ (nullable instancetype)blsKeyWithPublicKey:(UInt384)publicKey onChain:(id<DSChainProtocol>)chain;
- (nullable instancetype)initWithPublicKey:(UInt384)publicKey onChain:(id<DSChainProtocol>)chain;
+ (nullable instancetype)blsKeyWithPrivateKey:(UInt256)secretKey onChain:(id<DSChainProtocol>)chain;
- (nullable instancetype)initWithPrivateKey:(UInt256)secretKey onChain:(id<DSChainProtocol>)chain;

- (DSBLSKey *_Nullable)deriveToPath:(NSIndexPath *)derivationPath;
- (DSBLSKey *_Nullable)publicDeriveToPath:(NSIndexPath *)derivationPath;

- (BOOL)verify:(UInt256)messageDigest signature:(UInt768)signature;

- (UInt768)signDigest:(UInt256)messageDigest;
- (UInt768)signData:(NSData *)data;
- (UInt768)signDataSingleSHA256:(NSData *)data;

+ (UInt768)aggregateSignatures:(NSArray *)signatures withPublicKeys:(NSArray *)publicKeys withMessages:(NSArray *)messages;

@end

NS_ASSUME_NONNULL_END
