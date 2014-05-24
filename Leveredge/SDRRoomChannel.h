//
//  SDRRoomChannel.h
//  Leveredge
//
//  Created by Shane Rogers on 5/21/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface SDRRoomChannel : NSObject <JSONSerializable>

@property (nonatomic, strong) NSMutableArray *rooms;

@end
