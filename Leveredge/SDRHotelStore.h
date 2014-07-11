//
//  SDRHotelStore.h
//  Leveredge
//
//  Created by Shane Rogers on 5/21/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDRHotel.h"
#import "SDRHotelChannel.h"

@interface SDRHotelStore : NSObject {
    NSMutableArray *allHotels;
}

+ (SDRHotelStore *)sharedStore;
- (void)addUniqueHotels:(SDRHotel *)hotel;
- (NSMutableArray *)allHotels;

- (void)fetchHotelsWithCompletion:(void (^)(NSArray *obj, NSError *err))block;

@end
