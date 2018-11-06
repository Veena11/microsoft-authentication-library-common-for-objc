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
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "MSIDLegacyTokenCacheProvider.h"
#import "MSIDLegacyTokenCacheAccessor.h"

@interface MSIDLegacyTokenCacheProvider()

@property (nonatomic) MSIDLegacyTokenCacheAccessor *legacyAccessor;

@end

@implementation MSIDLegacyTokenCacheProvider

#pragma mark - Init

- (nullable instancetype)initWithLegacyAccessor:(MSIDLegacyTokenCacheAccessor *)legacyAccessor
{
    self = [super init];

    if (self)
    {
        self.legacyAccessor = legacyAccessor;
    }

    return self;
}

#pragma mark - MSIDSilentTokenRequestHandling

- (nullable MSIDAccessToken *)accessTokenWithParameters:(MSIDRequestParameters *)requestParameters
                                                  error:(NSError **)error
{
    return nil;
}

- (nullable MSIDTokenResult *)resultWithAccessToken:(MSIDAccessToken *)accessToken
                                  requestParameters:(MSIDRequestParameters *)requestParameters
                                              error:(NSError * _Nullable * _Nullable)error
{
    return nil;
}

- (nullable MSIDRefreshToken *)familyRefreshTokenWithParameters:(MSIDRequestParameters *)requestParameters
                                                          error:(NSError * _Nullable * _Nullable)error
{
    return nil;
}

- (nullable MSIDRefreshToken *)multiResourceTokenWithParameters:(MSIDRequestParameters *)requestParameters
                                                          error:(NSError * _Nullable * _Nullable)error
{
    return nil;
}

- (BOOL)updateClientFamilyStateWithRequestPrameters:(MSIDRequestParameters *)requestParameters
                                        newFamilyId:(NSString *)newFamilyId
                                        updateError:(NSError **)updateError
{
    return YES;
}

- (id<MSIDCacheAccessor>)cacheAccessor
{
    return self.legacyAccessor;
}

@end