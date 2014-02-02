//
//  SDRVendorChannel.h
//  Leveredge
//
//  Created by Shane Rogers on 2/2/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface SDRVendorChannel : NSObject <JSONSerializable>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSMutableArray *vendors;

@end
