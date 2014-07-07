//
//  LCHTTPClient.m
//  BillsTool
//
//  Created by guoyalun on 9/10/13.
//  Copyright (c) 2013 郭亚伦. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "PCHTTPClient.h"
#import "AFJSONRequestOperation.h"


@implementation PCHTTPClient

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self setParameterEncoding:AFJSONParameterEncoding];
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    [self setDefaultHeader:@"agent" value:@"iOS"];
    [self setDefaultHeader:@"VersionCode" value:kVersionCode];


	NSString *version = (NSString *)[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    [self setDefaultHeader:@"version" value:version];
    
    
    return self;
}

+ (id)sharedClient
{
    static PCHTTPClient *instace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instace = [[PCHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:HTTP_BASE_URL]];
    });
    return instace;
}


- (void)postPath:(NSString *)path
      parametersByArray:(NSArray *)parameters
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    NSURLRequest *request = [self requestWithMethod:@"POST" path:path parametersByArray:parameters];
    if (!request) {
        return;
    }
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    [self enqueueHTTPRequestOperation:operation];
}

- (void)putPath:(NSString *)path
parametersByArray:(NSArray *)parameters
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    NSURLRequest *request = [self requestWithMethod:@"PUT" path:path parametersByArray:parameters];
    if (!request) {
        return;
    }
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    [self enqueueHTTPRequestOperation:operation];
}


- (NSMutableURLRequest *)requestWithMethod:(NSString *)method   //POST or PUT
                                      path:(NSString *)path
                                parametersByArray:(NSArray *)parameters
{
     NSParameterAssert(method);
     if ([method isEqualToString:@"GET"] || [method isEqualToString:@"HEAD"] || [method isEqualToString:@"DELETE"]) {
         return nil;
     }

    if (!path) {
        return nil;
    }

    NSURL *url = [NSURL URLWithString:path relativeToURL:self.baseURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:method];
    [request setAllHTTPHeaderFields:self.defaultHeaders];
	[request setTimeoutInterval:10];

	if (parameters) {
        NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(self.stringEncoding));
        NSError *error = nil;
        [request setValue:[NSString stringWithFormat:@"application/json; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error]];

        if (error) {
            NSLog(@"%@ %@: %@", [self class], NSStringFromSelector(_cmd), error);
        }
        
    }

    return request;

}

- (void)postPath:(NSString *)path parametersByNSData:(NSData *)data success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
	NSURLRequest *request = [self requestWithMethod:@"POST" path:path parametersByData:data];
	if (!request) {
		return;
	}
	AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
	[self enqueueHTTPRequestOperation:operation];
}

- (NSURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parametersByData:(NSData *)data {
	NSParameterAssert(method);
	if ([method isEqualToString:@"GET"] || [method isEqualToString:@"HEAD"] || [method isEqualToString:@"DELETE"]) {
		return nil;
	}

	if (!path) {
		return nil;
	}

	NSURL *url = [NSURL URLWithString:path relativeToURL:self.baseURL];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
	[request setHTTPMethod:method];
	[request setAllHTTPHeaderFields:self.defaultHeaders];
	[request setTimeoutInterval:10];

	if (data.length<=0) {
		return nil;
	}

	[request setValue:[NSString stringWithFormat:@"image/jpg"] forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:data];

	return request;
}


@end
