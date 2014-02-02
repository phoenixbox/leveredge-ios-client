//
//  SDRVendorStore.m
//  Leveredge
//
//  Created by Shane Rogers on 2/2/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRVendorStore.h"
#import "SDRAppConstants.h"
#import "SDRConnection.h"
#import "SDRVendorChannel.h"
#import "SDRVendor.h"

@implementation SDRVendorStore

+(SDRVendorStore *)sharedStore {
    static SDRVendorStore *vendorStore = nil;
    
    if(!vendorStore) {
        vendorStore = [[SDRVendorStore alloc]init];
    };
    return vendorStore;
}

- (void)fetchVendorsWithCompletion:(void (^)(SDRVendorChannel *, NSError *))block {
    // Prepare the request URL
    NSString *requestString = [NSString stringWithFormat:kAPIVendorsIndex];
    NSURL *url = [NSURL URLWithString:requestString];
    
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

@end
