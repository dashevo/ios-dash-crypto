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

#import "NSCoder+Dash.h"

#import "BigIntTypes.h"
#import "NSData+Bitcoin.h"

@implementation NSCoder (Dash)

- (void)encodeUInt256:(UInt256)value forKey:(NSString *)string {
    [self encodeObject:[NSData dataWithUInt256:value] forKey:string];
}

- (UInt256)decodeUInt256ForKey:(NSString *)string {
    NSData *data = [self decodeObjectOfClass:[NSData class] forKey:string];
    UInt256 r = *(UInt256 *)data.bytes;
    return r;
}

@end
