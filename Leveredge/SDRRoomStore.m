//
//  SDRRoomStore.m
//  Leveredge
//
//  Created by Shane Rogers on 5/21/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRRoomStore.h"

@implementation SDRRoomStore

+ (SDRRoomStore *)sharedStore {
    static SDRRoomStore *roomStore = nil;
    
    if (!roomStore) {
        roomStore = [[SDRRoomStore alloc]init];
    };
    return roomStore;
}

@end
