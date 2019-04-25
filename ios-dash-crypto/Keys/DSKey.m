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

#import "DSKey.h"
#import "NSData+Bitcoin.h"
#import "NSData+Dash.h"
#import "NSMutableData+Dash.h"
#import "NSString+Bitcoin.h"
#import "NSString+Dash.h"

@implementation DSKey

- (UInt160)hash160 {
    return self.publicKeyData.hash160;
}

+ (NSString *)addressWithPublicKeyData:(NSData *)data forChain:(id<DSChainProtocol>)chain {
    NSParameterAssert(data);
    NSParameterAssert(chain);

    NSMutableData *d = [NSMutableData secureDataWithCapacity:160 / 8 + 1];
    uint8_t version;
    UInt160 hash160 = data.hash160;

    if ([chain isMainnet]) {
        version = DASH_PUBKEY_ADDRESS;
    }
    else {
        version = DASH_PUBKEY_ADDRESS_TEST;
    }

    [d appendBytes:&version length:1];
    [d appendBytes:&hash160 length:sizeof(hash160)];
    return [NSString base58checkWithData:d];
}

- (NSString *)addressForChain:(id<DSChainProtocol>)chain {
    NSParameterAssert(chain);

    return [DSKey addressWithPublicKeyData:self.publicKeyData forChain:chain];
}

+ (NSString *)randomAddressForChain:(id<DSChainProtocol>)chain {
    NSParameterAssert(chain);

    UInt160 randomNumber = UINT160_ZERO;
    for (int i = 0; i < 5; i++) {
        randomNumber.u32[i] = arc4random();
    }

    return [[NSData dataWithUInt160:randomNumber] addressFromHash160DataForChain:chain];
}

- (NSString *)privateKeyStringForChain:(id<DSChainProtocol>)chain {
    return nil;
}

@end
