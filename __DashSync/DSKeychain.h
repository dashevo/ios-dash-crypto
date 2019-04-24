//
//  Created by Andrew Podkovyrin
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

NS_ASSUME_NONNULL_BEGIN

BOOL setKeychainData(NSData *_Nullable data, NSString *key, BOOL authenticated);
BOOL hasKeychainData(NSString *key, NSError **error);
NSData *getKeychainData(NSString *key, NSError **error);
BOOL setKeychainInt(int64_t i, NSString *key, BOOL authenticated);
int64_t getKeychainInt(NSString *key, NSError **error);
BOOL setKeychainString(NSString *s, NSString *key, BOOL authenticated);
NSString *getKeychainString(NSString *key, NSError **error);
BOOL setKeychainDict(NSDictionary *dict, NSString *key, BOOL authenticated);
NSDictionary *getKeychainDict(NSString *key, NSError **error);
BOOL setKeychainArray(NSArray *array, NSString *key, BOOL authenticated);
NSArray *getKeychainArray(NSString *key, NSError **error);

NS_ASSUME_NONNULL_END
