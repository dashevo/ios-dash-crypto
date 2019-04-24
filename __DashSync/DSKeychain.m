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

#import "DSKeychain.h"

#import "DashCoreLogging.h"

#define SEC_ATTR_SERVICE @"org.dashfoundation.dash"

BOOL setKeychainData(NSData *data, NSString *key, BOOL authenticated) {
    NSCParameterAssert(key);
    if (!key) return NO;

    id accessible = (authenticated) ? (__bridge id)kSecAttrAccessibleWhenUnlockedThisDeviceOnly
                                    : (__bridge id)kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly;
    NSDictionary *query = @ { (__bridge id)kSecClass : (__bridge id)kSecClassGenericPassword,
                              (__bridge id)kSecAttrService : SEC_ATTR_SERVICE,
                              (__bridge id)kSecAttrAccount : key };

    if (SecItemCopyMatching((__bridge CFDictionaryRef)query, NULL) == errSecItemNotFound) {
        if (!data) return YES;

        NSDictionary *item = @ { (__bridge id)kSecClass : (__bridge id)kSecClassGenericPassword,
                                 (__bridge id)kSecAttrService : SEC_ATTR_SERVICE,
                                 (__bridge id)kSecAttrAccount : key,
                                 (__bridge id)kSecAttrAccessible : accessible,
                                 (__bridge id)kSecValueData : data };
        OSStatus status = SecItemAdd((__bridge CFDictionaryRef)item, NULL);

        if (status == noErr) return YES;
        DSCDLog(@"SecItemAdd error: %@", [NSError errorWithDomain:NSOSStatusErrorDomain code:status userInfo:nil].localizedDescription);
        return NO;
    }

    if (!data) {
        OSStatus status = SecItemDelete((__bridge CFDictionaryRef)query);

        if (status == noErr) return YES;
        DSCDLog(@"SecItemDelete error: %@", [NSError errorWithDomain:NSOSStatusErrorDomain code:status userInfo:nil].localizedDescription);
        return NO;
    }

    NSDictionary *update = @ { (__bridge id)kSecAttrAccessible : accessible,
                               (__bridge id)kSecValueData : data };
    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)query, (__bridge CFDictionaryRef)update);

    if (status == noErr) return YES;
    DSCDLog(@"SecItemUpdate error: %@", [NSError errorWithDomain:NSOSStatusErrorDomain code:status userInfo:nil].localizedDescription);
    return NO;
}

BOOL hasKeychainData(NSString *key, NSError **error) {
    NSCParameterAssert(key);
    if (!key) return NO;

    NSDictionary *query = @{(__bridge id)kSecClass : (__bridge id)kSecClassGenericPassword,
                            (__bridge id)kSecAttrService : SEC_ATTR_SERVICE,
                            (__bridge id)kSecAttrAccount : key,
                            (__bridge id)kSecReturnRef : @YES};
    CFDataRef result = nil;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);

    if (status == errSecItemNotFound) return NO;
    if (status == noErr) return YES;
    DSCDLog(@"SecItemCopyMatching error: %@", [NSError errorWithDomain:NSOSStatusErrorDomain code:status userInfo:nil].localizedDescription);
    if (error) *error = [NSError errorWithDomain:NSOSStatusErrorDomain code:status userInfo:nil];
    return NO;
}

NSData *getKeychainData(NSString *key, NSError **error) {
    NSDictionary *query = @{(__bridge id)kSecClass : (__bridge id)kSecClassGenericPassword,
                            (__bridge id)kSecAttrService : SEC_ATTR_SERVICE,
                            (__bridge id)kSecAttrAccount : key,
                            (__bridge id)kSecReturnData : @YES};
    CFDataRef result = nil;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);

    if (status == errSecItemNotFound) return nil;
    if (status == noErr) return CFBridgingRelease(result);
    DSCDLog(@"SecItemCopyMatching error: %@", [NSError errorWithDomain:NSOSStatusErrorDomain code:status userInfo:nil].localizedDescription);
    if (error) *error = [NSError errorWithDomain:NSOSStatusErrorDomain code:status userInfo:nil];
    return nil;
}

BOOL setKeychainInt(int64_t i, NSString *key, BOOL authenticated) {
    @autoreleasepool {
        NSMutableData *d = [NSMutableData secureDataWithLength:sizeof(int64_t)];

        *(int64_t *)d.mutableBytes = i;
        return setKeychainData(d, key, authenticated);
    }
}

int64_t getKeychainInt(NSString *key, NSError **error) {
    @autoreleasepool {
        NSData *d = getKeychainData(key, error);

        return (d.length == sizeof(int64_t)) ? *(int64_t *)d.bytes : 0;
    }
}

BOOL setKeychainString(NSString *s, NSString *key, BOOL authenticated) {
    @autoreleasepool {
        NSData *d = (s) ? CFBridgingRelease(CFStringCreateExternalRepresentation(SecureAllocator(), (CFStringRef)s, kCFStringEncodingUTF8, 0))
                        : nil;

        return setKeychainData(d, key, authenticated);
    }
}

NSString *getKeychainString(NSString *key, NSError **error) {
    @autoreleasepool {
        NSData *d = getKeychainData(key, error);

        return (d) ? CFBridgingRelease(CFStringCreateFromExternalRepresentation(SecureAllocator(), (CFDataRef)d, kCFStringEncodingUTF8))
                   : nil;
    }
}

BOOL setKeychainDict(NSDictionary *dict, NSString *key, BOOL authenticated) {
    @autoreleasepool {
        NSData *d = (dict) ? [NSKeyedArchiver archivedDataWithRootObject:dict] : nil;

        return setKeychainData(d, key, authenticated);
    }
}

NSDictionary *getKeychainDict(NSString *key, NSError **error) {
    @autoreleasepool {
        NSData *d = getKeychainData(key, error);

        return (d) ? [NSKeyedUnarchiver unarchiveObjectWithData:d] : nil;
    }
}

BOOL setKeychainArray(NSArray *array, NSString *key, BOOL authenticated) {
    @autoreleasepool {
        NSData *d = (array) ? [NSKeyedArchiver archivedDataWithRootObject:array] : nil;

        return setKeychainData(d, key, authenticated);
    }
}

NSArray *getKeychainArray(NSString *key, NSError **error) {
    @autoreleasepool {
        NSData *d = getKeychainData(key, error);

        return (d) ? [NSKeyedUnarchiver unarchiveObjectWithData:d] : nil;
    }
}

NSOrderedSet *getKeychainOrderedSet(NSString *key, NSError **error) {
    @autoreleasepool {
        NSData *d = getKeychainData(key, error);

        return (d) ? [NSKeyedUnarchiver unarchiveObjectWithData:d] : nil;
    }
}

BOOL setKeychainOrderedSet(NSOrderedSet *orderedSet, NSString *key, BOOL authenticated) {
    @autoreleasepool {
        NSData *d = (orderedSet) ? [NSKeyedArchiver archivedDataWithRootObject:orderedSet] : nil;

        return setKeychainData(d, key, authenticated);
    }
}
