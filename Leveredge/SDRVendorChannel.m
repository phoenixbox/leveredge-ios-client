//
//  SDRVendorChannel.m
//  Leveredge
//
//  Created by Shane Rogers on 2/2/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRVendorChannel.h"

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
- (void)readFromJSONDictionary:(NSDictionary *)d
{

}
@end
