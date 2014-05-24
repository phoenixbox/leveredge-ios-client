//
//  SDRRoomChannel.m
//  Leveredge
//
//  Created by Shane Rogers on 5/21/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRRoomChannel.h"
#import "SDRRoom.h"

@implementation SDRRoomChannel

-(id)init {
    self = [super init];
    
    if(!self){
        self.rooms = [NSMutableArray new];
    }
    return self;
}

-(void)readFromNSObject:(NSObject *)object {
}


@end
