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
#import "NSData+Bitcoin.h"

@interface NSData (Dash)

- (UInt256)x11;
- (UInt512)blake512;
- (UInt512)bmw512;
- (UInt512)groestl512;
- (UInt512)skein512;
- (UInt512)jh512;
- (UInt512)keccak512;
- (UInt512)luffa512;
- (UInt512)cubehash512;
- (UInt512)shavite512;
- (UInt512)simd512;
- (UInt512)echo512;

+ (NSData *)dataFromHexString:(NSString *)string;

@end
