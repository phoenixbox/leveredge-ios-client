//
//  SDRUser.m
//  Leveredge
//
//  Created by Shane Rogers on 2/3/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRUser.h"
#import "SDRVendor.h"
#import "SDRAuthStore.h"

@implementation SDRUser

@synthesize vendors;

- (void)readFromNSObject:(NSObject *)object {
    if([object isMemberOfClass:[NSArray class]]){
        NSLog(@"User array response placeholder");
    } else if ([object isKindOfClass:[NSDictionary class]]){
        [self userReadFromJSONDictionary:(NSDictionary *)object];
    }
}

- (void)userReadFromJSONDictionary:(NSDictionary *)d {
    [self setUserID:[d objectForKey:@"id"]];
    [self setEmail:[d objectForKey:@"email"]];
    [self setAuthenticationToken:[d objectForKey:@"authentication_token"]];
    
    for(NSDictionary *vendorDict in [d objectForKey:@"vendors"]){
        if(!self.vendors){self.vendors = [NSMutableArray new];}
        SDRVendor *vendor = [SDRVendor new];
        vendor = [vendor vendorFromJSONDictionary:vendorDict];
        
        [self.vendors addObject:vendor];
    };
    
    [[SDRAuthStore sharedStore] addCurrentUser:self];
}

@end
