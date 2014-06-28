//
//  SDRRoomStore.h
//  Leveredge
//
//  Created by Shane Rogers on 5/21/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDRRoom.h"
#import "SDRRoomChannel.h"

@interface SDRRoomStore : NSObject{
    NSMutableArray *allRooms;
}

+ (SDRRoomStore *)sharedStore;
- (void)addUniqueRooms:(SDRRoom *)room;
- (NSMutableArray *)allRooms;

- (void)fetchRoomsWithCompletion:(void (^)(SDRRoomChannel *obj, NSError *err))block;

@end
