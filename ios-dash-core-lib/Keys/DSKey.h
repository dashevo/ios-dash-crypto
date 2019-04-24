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

NS_ASSUME_NONNULL_BEGIN

@interface DSKey : NSObject

@property (nullable, nonatomic, readonly) NSData *publicKeyData;
@property (nonatomic, readonly) UInt160 hash160;
@property (nonatomic, readonly) NSString *secretKeyString;

- (NSString *)addressForChain:(id<DSChainProtocol>)chain;
+ (NSString *)randomAddressForChain:(id<DSChainProtocol>)chain;
+ (NSString *)addressWithPublicKeyData:(NSData *)data forChain:(id<DSChainProtocol>)chain;
- (NSString *_Nullable)privateKeyStringForChain:(id<DSChainProtocol>)chain;

@end

NS_ASSUME_NONNULL_END
