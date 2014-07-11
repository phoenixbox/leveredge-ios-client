//
//  SDRHotel.h
//  Leveredge
//
//  Created by Shane Rogers on 5/21/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "JSONModel.h"
#import "JSONSerializable.h"

@protocol SDRHotel @end

@interface SDRHotel : JSONModel

@property (nonatomic) NSNumber *id;
@property (nonatomic, strong) NSString *name;
//@property (nonatomic) NSNumber *userID;
//@property (nonatomic, strong) NSString *video_url;

@end
