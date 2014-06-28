//
//  SDRRoomStore.m
//  Leveredge
//
//  Created by Shane Rogers on 5/21/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRRoomStore.h"
#import "SDRAuthStore.h"
#import "SDRAppConstants.h"
#import "AFNetworking.h"

@implementation SDRRoomStore

+ (SDRRoomStore *)sharedStore {
    static SDRRoomStore *roomStore = nil;
    
    if (!roomStore) {
        roomStore = [[SDRRoomStore alloc]init];
    };
    return roomStore;
}

- (void)addUniqueRooms:(SDRRoom *)room {
    if(!allRooms){
        allRooms = [NSMutableArray new];
    }
    //  RESTART: Find or create
    
    NSInteger ind = [[self allRooms] indexOfObject:room];
    if (ind == NSNotFound) {
        [allRooms addObject:room];
    }
}

- (NSMutableArray *)allRooms {
    return allRooms;
}

- (void)fetchRoomsWithCompletion:(void (^)(SDRRoomChannel *obj, NSError *err))block {
    // Build up the request string
    NSString *requestString = [self authenticateRequest:kAPIRoomsIndex];
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
//    [operation setCompletionBlockWithSuccess:^(SDRRoomChannel *obj, id responseObject) {
//        self.room = (NSDictionary *)responseObject;
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        block(operation, error);
//    }];
}
//- (void)fetchVendorsWithCompletion:(void (^)(SDRRoomChannel *obj, NSError *err))block {
//// Prepare the request URL
////    NSString *requestString = [self authenticateRequest:kProdAPIVendorsIndex];
//NSString *requestString = [self authenticateRequest:kAPIVendorsIndex];
//NSURL *url = [NSURL URLWithString:requestString];
//
////Append the user auth token parameter
//
//// Set the connection
//NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:1000.0];
//SDRVendorChannel *vendorChannel = [SDRVendorChannel new];
//SDRConnection *connection = [[SDRConnection alloc]initWithRequest:req];
//
//// Set the connection success block - to trigger directors completion block
//[connection setCompletionBlock:^(SDRVendorChannel *obj, NSError *err){
//    if(!err){
//        // Cache the response if needed
//    }
//    block(obj, err);
//}];
//[connection setJsonRootObject:vendorChannel];
//
//[connection start];
//}

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
