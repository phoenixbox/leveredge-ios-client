//
//  SDRUser.h
//  Leveredge
//
//  Created by Shane Rogers on 2/3/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface SDRUser : NSObject <JSONSerializable>

@property (nonatomic) NSNumber *userID;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *authenticationToken;
@property (nonatomic, strong) NSMutableArray *vendors;

@end
