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
#import "SDRUser.h"

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
    //  RESTART: Find or create
    [allVendors addObject:vendor];
}

- (NSMutableArray *)allVendors {
    return allVendors;
}

- (void)fetchVendorsWithCompletion:(void (^)(SDRVendorChannel *, NSError *))block {
    // Prepare the request URL
    NSString *requestString = [self authenticateRequest:kAPIVendorsIndex];
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

- (void)createPreQualificationForVendor:(SDRVendor *)vendor WithCompletion:(void (^)(SDRUser *, NSError *))block {
    
    NSString *requestString = [self authenticateRequest:kAPIPreQualifiedEndpoint];
    requestString = [requestString stringByAppendingString:(@"&vendor_id=")];
    requestString = [requestString stringByAppendingString:[vendor.vendorID stringValue]];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestString] cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:1000.0];
    
    [req setHTTPMethod:@"POST"];
    // Set the header fields
    [req setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"accept"];
    
    SDRUser *user = [SDRUser new];
    SDRConnection *connection = [[SDRConnection alloc]initWithRequest:req];
    
    // Set the connection success block - to trigger directors completion block
    [connection setCompletionBlock:^(SDRUser *obj, NSError *err){
        if(!err){
            // Cache the response if needed
        }
        block(obj, err);
    }];
    [connection setJsonRootObject:user];
    
    [connection start];
}

- (void)removePreQualificationForVendor:(SDRVendor *)vendor WithCompletion:(void (^)(SDRUser *, NSError *))block {
    SDRAuthStore *authStore = [SDRAuthStore sharedStore];
    NSString *email = authStore.currentUser.email;
    NSString *token = authStore.currentUser.authenticationToken;
    NSString *string = @"/";
    NSString *requestString = [kAPIPreQualifiedEndpoint stringByAppendingString:string];
    requestString = [requestString stringByAppendingString:[vendor.vendorID stringValue]];
    requestString = [requestString stringByAppendingString:(@"?email=")];
    requestString = [requestString stringByAppendingString:email];
    requestString = [requestString stringByAppendingString:(@"&authentication_token=")];
    requestString = [requestString stringByAppendingString:token];
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestString] cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:1000.0];
    
    [req setHTTPMethod:@"DELETE"];
    // Set the header fields
    [req setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"accept"];
    
    SDRUser *user = [SDRUser new];
    SDRConnection *connection = [[SDRConnection alloc]initWithRequest:req];
    
    // Set the connection success block - to trigger directors completion block
    [connection setCompletionBlock:^(SDRUser *obj, NSError *err){
        if(!err){
            // Cache the response if needed
        }
        block(obj, err);
    }];
    [connection setJsonRootObject:user];
    
    [connection start];
}

- (NSString *)authenticateRequest:(NSString *)requestString {
    SDRAuthStore *authStore = [SDRAuthStore sharedStore];
    NSLog(@"CurrentUser %@", authStore.currentUser);
    NSString *email = authStore.currentUser.email;
    NSString *token = authStore.currentUser.authenticationToken;
    requestString = [requestString stringByAppendingString:(@"?email=")];
    requestString = [requestString stringByAppendingString:email];
    requestString = [requestString stringByAppendingString:(@"&authentication_token=")];
    requestString = [requestString stringByAppendingString:token];
    
    return requestString;
}



@end
