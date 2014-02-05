//
//  SDRVendor.h
//  Leveredge
//
//  Created by Shane Rogers on 2/2/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface SDRVendor : NSObject <JSONSerializable>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *vendorType;
@property (nonatomic, strong) NSString *thumbnail;
//@property (nonatomic, strong) UIImageView *thumbnail;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *websiteUrl;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zipCode;

- (void)readFromJSONDictionary:(NSDictionary *)d;

@end
