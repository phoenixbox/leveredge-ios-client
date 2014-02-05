//
//  SDRUser.m
//  Leveredge
//
//  Created by Shane Rogers on 2/3/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRUser.h"
#import "SDRAuthStore.h"

@implementation SDRUser

- (void)readFromNSObject:(NSObject *)object {
    if([object isMemberOfClass:[NSArray class]]){
        NSLog(@"User array response placeholder");
    } else if ([object isKindOfClass:[NSDictionary class]]){
        [self readFromJSONDictionary:(NSDictionary *)object];
    }
}

- (void)readFromJSONDictionary:(NSDictionary *)d {
    if([d objectForKey:@"authentication_token"]){
        [self setEmail:[d objectForKey:@"email"]];
        [self setAuthenticationToken:[d objectForKey:@"authentication_token"]];
        [[SDRAuthStore sharedStore] addCurrentUser:self];
    }
}

@end
