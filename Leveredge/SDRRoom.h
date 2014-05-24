//
//  SDRRoom.h
//  Leveredge
//
//  Created by Shane Rogers on 5/21/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "JSONSerializable.h"

@interface SDRRoom : NSObject <JSONSerializable>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) AVAsset *video;

@end
