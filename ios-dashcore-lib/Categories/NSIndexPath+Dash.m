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

#import "NSIndexPath+Dash.h"

@implementation NSIndexPath (Dash)

- (NSIndexPath *)indexPathByRemovingFirstIndex {
    if (self.length == 1) return [[NSIndexPath alloc] init];
    NSUInteger indexes[[self length]];
    [self getIndexes:indexes range:NSMakeRange(1, [self length] - 1)];
    return [NSIndexPath indexPathWithIndexes:indexes length:self.length - 1];
}

@end
