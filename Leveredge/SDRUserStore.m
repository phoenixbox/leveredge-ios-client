//
//  SDRUserStore.m
//  Leveredge
//
//  Created by Shane Rogers on 2/3/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRUserStore.h"
#import "SDRAppConstants.h"
#import "SDRConnection.h"

@implementation SDRUserStore

+ (SDRUserStore *)sharedStore {
    static SDRUserStore *userStore = nil;
    
    if(!userStore) {
        userStore = [[SDRUserStore alloc]init];
    };
    return userStore;
}

- (void)addVendor:(SDRUser *)user {
    if(!currentUser){
        currentUser = [SDRUser new];
    }
    currentUser = user;
}

- (SDRUser *)currentUser {
    return currentUser;
}

- (void)loginRequest:(NSDictionary *)parameters withCompletionBlock:(void (^)(SDRUser *obj, NSError *err))block {
    // Create the request.
    NSString *requestString = [self constructLoginRequest:parameters];
    // Prepare the request URL
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestString] cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:1000.0];

    // Specify that it will be a POST request
    [req setHTTPMethod:@"POST"];
    // Set the header fields
    [req setValue:@"application/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    // Set the connection
    SDRUser *user = [SDRUser new];
    SDRConnection *connection = [[SDRConnection alloc]initWithRequest:req];
    
    [connection setCompletionBlock:^(SDRUser *obj, NSError *err){
        if(!err){
        }
        block(obj, err);
    }];
    [connection setJsonRootObject:user];
    
    [connection start];
}

- (NSString *)constructLoginRequest:(NSDictionary *)parameters {
    NSString *email = [parameters objectForKey:@"email"];
    NSString *password = [parameters objectForKey:@"password"];
    
    NSString *requestString = [NSString stringWithFormat:kAPIUserLogin];
    requestString = [requestString stringByAppendingString:(@"?email=")];
    requestString = [requestString stringByAppendingString:email];
    requestString = [requestString stringByAppendingString:(@"&password=")];
    return [requestString stringByAppendingString:password];
}

@end
