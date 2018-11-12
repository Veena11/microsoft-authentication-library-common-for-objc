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

#import "MSIDBrokerTokenRequest.h"
#import "MSIDBrokerPayload.h"
#import "MSIDInteractiveRequestParameters.h"
#import "MSIDAppExtensionUtil.h"
#import "MSIDNotifications.h"
#import "MSIDBrokerKeyProvider.h"
#import "MSIDKeychainTokenCache.h"

@interface MSIDBrokerTokenRequest()

@property (nonatomic, readwrite) MSIDInteractiveRequestParameters *requestParameters;
@property (nonatomic, readwrite) MSIDOauth2Factory *oauthFactory;
@property (nonatomic, readwrite) MSIDTokenResponseValidator *tokenResponseValidator;
@property (nonatomic, readwrite) MSIDBrokerKeyProvider *brokerKeyProvider;

@end

@implementation MSIDBrokerTokenRequest

#pragma mark - Init

- (nullable instancetype)initWithRequestParameters:(nonnull MSIDInteractiveRequestParameters *)parameters
                                      oauthFactory:(nonnull MSIDOauth2Factory *)oauthFactory
                            tokenResponseValidator:(nonnull MSIDTokenResponseValidator *)tokenResponseValidator
{
    self = [super init];

    if (self)
    {
        _requestParameters = parameters;
        _oauthFactory = oauthFactory;
        _tokenResponseValidator = tokenResponseValidator;

        // TODO: verify current behavior of this keychain access group and migration scenarios
        NSString *accessGroup = parameters.keychainAccessGroup ?: MSIDKeychainTokenCache.defaultKeychainGroup;
        _brokerKeyProvider = [[MSIDBrokerKeyProvider alloc] initWithGroup:accessGroup];
    }

    return self;
}

#pragma mark - Acquire token

- (BOOL)launchBrokerWithError:(NSError **)error
{
    NSError *brokerError = nil;

    NSData *brokerKey = [self.brokerKeyProvider brokerKeyWithError:&brokerError];

    if (!brokerKey)
    {
        MSID_LOG_ERROR(self.requestParameters, @"Failed to retrieve broker key with error %ld, %@", (long)brokerError.code, brokerError.domain);
        MSID_LOG_ERROR_PII(self.requestParameters, @"Failed to retrieve broker key with error %@", brokerError);

        if (error)
        {
            *error = brokerError;
        }

        return NO;
    }

    NSString *base64UrlKey = [[NSString msidBase64UrlEncodedStringFromData:brokerKey] msidWWWFormURLEncode];

    if (!base64UrlKey)
    {
        MSID_LOG_ERROR(self.requestParameters, @"Unable to base64 encode broker key");
        MSIDFillAndLogError(error, MSIDErrorInternal, @"Unable to base64 encode broker key", self.requestParameters.correlationId);
        return NO;
    }

    MSIDBrokerPayload *brokerPayload = [self brokerPayloadWithKey:base64UrlKey error:&brokerError];

    if (!brokerPayload)
    {
        MSID_LOG_ERROR(self.requestParameters, @"Couldn't create broker payload");

        if (error)
        {
            *error = brokerError;
        }

        return NO;
    }

    NSDictionary *brokerResumeDictionary = brokerPayload.resumeDictionary;
    [[NSUserDefaults standardUserDefaults] setObject:brokerResumeDictionary forKey:[self brokerResumeDictionaryKey]];
    [[NSUserDefaults standardUserDefaults] synchronize];

    NSURL *brokerLaunchURL = brokerPayload.brokerRequestURL;

    if ([NSThread isMainThread])
    {
        [MSIDNotifications notifyWebAuthWillSwitchToBroker];
        [MSIDAppExtensionUtil sharedApplicationOpenURL:brokerLaunchURL];
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MSIDNotifications notifyWebAuthWillSwitchToBroker];
            [MSIDAppExtensionUtil sharedApplicationOpenURL:brokerLaunchURL];
        });
    }

    return YES;
}

#pragma mark - Abstract

- (MSIDBrokerPayload *)brokerPayloadWithKey:(NSString *)brokerKey error:(NSError **)error
{
    NSAssert(NO, @"Abstract method. implement in subclasses!");
    return nil;
}

- (NSString *)brokerResumeDictionaryKey
{
    NSAssert(NO, @"Abstract method. implement in subclasses!");
    return nil;
}

@end