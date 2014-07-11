//
//  SDRHotelStore.m
//  Leveredge
//
//  Created by Shane Rogers on 5/21/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRHotelStore.h"
#import "SDRAuthStore.h"
#import "SDRAppConstants.h"
#import "AFNetworking.h"

@implementation SDRHotelStore

+ (SDRHotelStore *)sharedStore {
    static SDRHotelStore *hotelStore = nil;
    
    if (!hotelStore) {
        hotelStore = [[SDRHotelStore alloc]init];
    };
    return hotelStore;
}

- (void)addUniqueHotels:(SDRHotel *)hotel {
    
    if(!allHotels){
        allHotels = (id)[NSMutableArray new];
    }
    //  RESTART: Find or create
    NSInteger ind = [[self allHotels] indexOfObject:hotel];
    if (ind == NSNotFound) {
        [allHotels addObject:hotel];
    }
}

- (NSMutableArray *)allHotels {
    return allHotels;
}

- (void)fetchHotelsWithCompletion:(void (^)(NSArray *obj, NSError *err))block {
    // Build up the request string
    NSString *requestString = [self authenticateRequest:kAPIHotelsIndex];
    NSURL *url = [NSURL URLWithString:requestString];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSArray *hotels = [SDRHotel arrayOfModelsFromData:data error:nil];
        block(hotels, nil);
        
    }] resume];
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
