//
//  SDRHotelChannel.h
//  Leveredge
//
//  Created by Shane Rogers on 5/21/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDRHotel.h"
#import "JSONModel.h"

@interface SDRHotelChannel : JSONModel

@property (strong, nonatomic) NSArray<SDRHotel, Optional> *hotels;

@end
