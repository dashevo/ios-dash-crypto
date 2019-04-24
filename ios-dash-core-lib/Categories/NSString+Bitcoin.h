//
//  NSString+Bitcoin.h
//  DashSync
//
//  Created by Aaron Voisine for BreadWallet on 5/13/13.
//  Copyright (c) 2013 Aaron Voisine <voisine@gmail.com>
//  Copyright (c) 2018 Dash Core Group <contact@dash.org>
//  Updated by Quantum Explorer on 05/11/18.
//  Copyright (c) 2018 Quantum Explorer <quantum@dash.org>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <Foundation/Foundation.h>

#import "DSChainProtocol.h"

// clang-format off
#define BITCOIN_PUBKEY_ADDRESS      0
#define BITCOIN_SCRIPT_ADDRESS      5
#define BITCOIN_PUBKEY_ADDRESS_TEST 111
#define BITCOIN_SCRIPT_ADDRESS_TEST 196
#define BITCOIN_PRIVKEY             128
#define BITCOIN_PRIVKEY_TEST        239

#define BIP38_NOEC_PREFIX      0x0142
#define BIP38_EC_PREFIX        0x0143
#define BIP38_NOEC_FLAG        (0x80 | 0x40)
#define BIP38_COMPRESSED_FLAG  0x20
#define BIP38_LOTSEQUENCE_FLAG 0x04
#define BIP38_INVALID_FLAG     (0x10 | 0x08 | 0x02 | 0x01)
// clang-format on

@interface NSString (Bitcoin)

+ (NSString *)base58WithData:(NSData *)d;
+ (NSString *)base58checkWithData:(NSData *)d;
+ (NSString *)hexWithData:(NSData *)d;
+ (NSString *)bitcoinAddressWithScriptPubKey:(NSData *)script forChain:(id<DSChainProtocol>)chain;
+ (NSString *)bitcoinAddressWithScriptSig:(NSData *)script forChain:(id<DSChainProtocol>)chain;

- (BOOL)isValidBase58;
- (NSData *)base58ToData;
- (NSData *)base58checkToData;
- (NSData *)hexToData;
- (NSData *)addressToHash160;

- (BOOL)isValidBitcoinAddressOnChain:(id<DSChainProtocol>)chain;
- (BOOL)isValidBitcoinPrivateKeyOnChain:(id<DSChainProtocol>)chain;
- (BOOL)isValidBitcoinBIP38Key; // BIP38 encrypted keys: https://github.com/bitcoin/bips/blob/master/bip-0038.mediawiki

@end
