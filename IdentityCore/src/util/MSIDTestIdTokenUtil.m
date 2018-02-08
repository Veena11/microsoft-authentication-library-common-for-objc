//------------------------------------------------------------------------------
//
// Copyright (c) Microsoft Corporation.
// All rights reserved.
//
// This code is licensed under the MIT License.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files(the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and / or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions :
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
//------------------------------------------------------------------------------

#import "MSIDTestIdTokenUtil.h"
#import "NSDictionary+MSIDTestUtil.h"
#import "MSIDTestCacheIdentifiers.h"

@implementation MSIDTestIdTokenUtil

+ (NSString *)defaultName
{
    return DEFAULT_TEST_ID_TOKEN_NAME;
}

+ (NSString *)defaultUsername
{
    return DEFAULT_TEST_ID_TOKEN_USERNAME;
}

+ (NSString *)defaultTenantId
{
    return DEFAULT_TEST_UTID;
}

+ (NSString *)defaultUniqueId
{
    return DEFAULT_TEST_ID_TOKEN_UNIQUE_ID;
}

+ (NSString *)defaultV2IdToken
{
    return [self idTokenWithName:[self defaultName] preferredUsername:[self defaultUsername]];
}

+ (NSString *)defaultV1IdToken
{
    return [self idTokenWithName:[self defaultName] upn:[self defaultUsername] tenantId:nil];
}

+ (NSString *)idTokenWithName:(NSString *)name
            preferredUsername:(NSString *)preferredUsername
{
    return [self idTokenWithName:name preferredUsername:preferredUsername tenantId:nil];
}

+ (NSString *)idTokenWithName:(NSString *)name
            preferredUsername:(NSString *)preferredUsername
                     tenantId:(NSString *)tid
{
    NSString *idTokenp1 = [@{ @"typ": @"JWT", @"alg": @"RS256", @"kid": @"_kid_value"} msidBase64UrlJson];
    NSString *idTokenp2 = [@{ @"iss" : @"issuer",
                              @"name" : name,
                              @"preferred_username" : preferredUsername,
                              @"tid" : tid ? tid : [self defaultTenantId],
                              @"oid" : [self defaultUniqueId]} msidBase64UrlJson];
    return [NSString stringWithFormat:@"%@.%@.%@", idTokenp1, idTokenp2, idTokenp1];
}

+ (NSString *)idTokenWithName:(NSString *)name
                          upn:(NSString *)upn
                     tenantId:(NSString *)tid
{
    NSString *idTokenp1 = [@{ @"typ": @"JWT", @"alg": @"RS256", @"kid": @"_kid_value"} msidBase64UrlJson];
    NSString *idTokenp2 = [@{ @"iss" : @"issuer",
                              @"name" : name,
                              @"upn" : upn,
                              @"tid" : tid ? tid : [self defaultTenantId],
                              @"oid" : [self defaultUniqueId]} msidBase64UrlJson];
    return [NSString stringWithFormat:@"%@.%@.%@", idTokenp1, idTokenp2, idTokenp1];
}

@end
