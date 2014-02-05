//
//  SDRVendorStore.m
//  Leveredge
//
//  Created by Shane Rogers on 2/2/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRVendorStore.h"
#import "SDRAuthStore.h"
#import "SDRAppConstants.h"
#import "SDRConnection.h"
#import "SDRVendorChannel.h"
#import "SDRVendor.h"

@implementation SDRVendorStore

+ (SDRVendorStore *)sharedStore {
    static SDRVendorStore *vendorStore = nil;
    
    if(!vendorStore) {
        vendorStore = [[SDRVendorStore alloc]init];
    };
    return vendorStore;
}

- (void)addVendor:(SDRVendor *)vendor {
    if(!allVendors){
        allVendors = [NSMutableArray new];
    }
    [allVendors addObject:vendor];
}

- (NSMutableArray *)allVendors {
    return allVendors;
}

- (void)fetchVendorsWithCompletion:(void (^)(SDRVendorChannel *, NSError *))block {
    // Prepare the request URL
    NSString *requestString = [self constructAuthenticatedRequest:kAPIVendorsIndex];
    
    NSURL *url = [NSURL URLWithString:requestString];
    
    //Append the user auth token parameter
    
    // Set the connection
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    SDRVendorChannel *vendorChannel = [SDRVendorChannel new];
    SDRConnection *connection = [[SDRConnection alloc]initWithRequest:req];
    
    // Set the connection success block - to trigger directors completion block
    [connection setCompletionBlock:^(SDRVendorChannel *obj, NSError *err){
        if(!err){
            // Cache the response if needed
        }
        block(obj, err);
    }];
    [connection setJsonRootObject:vendorChannel];
    
    [connection start];
}

- (NSString *)constructAuthenticatedRequest:(NSString *)endpoint {
    SDRAuthStore *authStore = [SDRAuthStore sharedStore];
    NSString *email = authStore.currentUser.email;
    NSString *token = authStore.currentUser.authenticationToken;
    
    NSString *requestString = [NSString stringWithFormat:@"%@",endpoint];
    requestString = [requestString stringByAppendingString:(@"?email=")];
    requestString = [requestString stringByAppendingString:email];
    requestString = [requestString stringByAppendingString:(@"&authentication_token=")];
    requestString = [requestString stringByAppendingString:token];
    
    return requestString;
}

@end
