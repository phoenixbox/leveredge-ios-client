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

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *authenticationToken;

@end
