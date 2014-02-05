//
//  SDRVendorChannel.m
//  Leveredge
//
//  Created by Shane Rogers on 2/2/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRVendorChannel.h"
#import "SDRVendor.h"

@implementation SDRVendorChannel

@synthesize title, vendors;

-(id)init
{
    self = [super init];
    
    if(self){
        // Create the container for the RSSItems that the channel has
        vendors = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)readFromJSONDictionary:(NSDictionary *)d {
}

- (void)readFromNSObject:(NSObject *)object {
    if([object isKindOfClass:[NSArray class]]){
        [self readFromJSONArray:(NSArray *)object];
    } else if ([object isKindOfClass:[NSDictionary class]]){
        [self readFromJSONDictionary:(NSDictionary *)object];
    }
}

- (void)readFromJSONArray:(NSArray *)array {
    for (NSDictionary *dictionary in array) {
        SDRVendor *vendor = [[SDRVendor alloc] init];
        // Pass the entry dictionary to the item so it can grab its ivars
        [vendor readFromJSONDictionary:dictionary];
        [vendors addObject:vendor];
    }
}
@end
