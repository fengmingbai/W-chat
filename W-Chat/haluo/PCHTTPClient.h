//
//  LCHTTPClient.h
//  BillsTool
//
//  Created by guoyalun on 9/10/13.
//  Copyright (c) 2013 郭亚伦. All rights reserved.
//

#import "AFHTTPClient.h"

typedef void (^SuccessBlock)(NSInteger statusCode, id responseObject);
typedef void (^FailureBlock)(NSInteger statusCode, NSError *error);



@interface PCHTTPClient : AFHTTPClient

+ (instancetype)sharedClient;


- (void)postPath:(NSString *)path
        parametersByArray:(NSArray *)parameters
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)postPath:(NSString *)path
		parametersByNSData:(NSData *)data
		success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
		failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


- (void)putPath:(NSString *)path
parametersByArray:(NSArray *)parameters
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
